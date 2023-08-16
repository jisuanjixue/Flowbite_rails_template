class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    attr_accessor :login
  
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  
    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.strip.downcase }]).first
    end

  has_many :posts, dependent: :destroy
end
