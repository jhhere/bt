class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates_format_of :email, with: VALID_EMAIL_REGEX

  has_secure_password
  validates_presence_of :password
  validates_length_of :password, minimum: 6
end
