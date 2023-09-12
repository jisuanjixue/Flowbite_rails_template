# == Schema Information
# Schema version: 20230912034307
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer
#  uid                    :string
#  username               :string
#  views                  :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  address_id             :bigint
#
# Indexes
#
#  index_users_on_address_id            (address_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (address_id => addresses.id)
#
class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :address, dependent: :destroy, inverse_of: :user, autosave: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
          :registerable,
          :recoverable, 
          :rememberable, 
          :validatable, 
          :omniauthable,
          omniauth_providers: %i[github],
          authentication_keys: [:login]

  validates :email, db_uniqueness: { rescue: :always }
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validate :validate_username
  validate :acceptable_image
  enum role: {user: 0, admin: 1} 

  after_initialize :set_default_role, if: :new_record?

  attr_writer :login

    # Class level accessor http://apidock.com/rails/Class/cattr_accessor
  cattr_accessor :form_steps do
    %w[sign_up set_name set_address find_users]
  end

   # Instance level accessor http://apidock.com/ruby/Module/attr_accessor
   attr_accessor :form_step

  def form_step
    @form_step ||= 'sign_up'
  end

  with_options if: -> { required_for_step?('set_name') } do
    validates :username, presence: true
  end

  validates_associated :address, if: -> { required_for_step?('set_address') }

  def required_for_step?(step)
    # All fields are required if no form step is present
    form_step.nil?

    # All fields from previous steps are required if the
    # step parameter appears before or we are on the current step
    form_steps.index(step.to_s) <= form_steps.index(form_step.to_s)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user |
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def login
    @login || username || email
  end

  def validate_username
    return unless User.exists?(email: username)
      errors.add(:username, :invalid)
  end

  def acceptable_image
    return unless avatar.attached?
    return if avatar.blob.byte_size <= 1.megabyte
      errors.add(:avatar, "is too big")
      acceptable_types = ["image/jpeg", "image/png"]
      return if acceptable_types.include?(main_image.content_type)
        errors.add(:main_image, "must be a JPEG or PNG")
      
  end


  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  private

  def set_default_role
    self.role ||= :user
  end

end
