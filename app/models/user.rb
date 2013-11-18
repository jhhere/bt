class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false

  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_format_of :email, with: VALID_EMAIL_REGEX

  has_secure_password
  validates_presence_of :password
  validates_length_of :password, minimum: 6

  before_create :create_remember_token

  has_many :goals, dependent: :destroy

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
