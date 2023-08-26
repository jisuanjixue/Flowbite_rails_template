class User < ApplicationRecord
  has_one_attached :avatar, dependent: :destroy
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

  validates :email, uniqueness: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validate :validate_username
  validate :acceptable_image

  attr_writer :login

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user |
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
    return unless User.where(email: username).exists?
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
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

end
