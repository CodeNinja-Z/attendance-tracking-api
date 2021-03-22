class User < ApplicationRecord

  # == Extensions ===========================================================

  has_secure_password
  
  # == Relationships ========================================================

  has_many :attendance_logs

  # == Validations ==========================================================

  validates :first_name, 
    presence: true,
    length: {minimum: 2, maximum: 40}

  validates :last_name, 
    presence: true,
    length: {minimum: 2, maximum: 40}

  validates :email, 
    email: true,
    uniqueness: true,
    length: { minimum: 2, maximum: 254 },
    presence: true

  validates :password, 
    confirmation: true,
    length: {minimum: 4}

  validates_presence_of :password_confirmation
  validates_presence_of :password_digest
end