class Goal < ActiveRecord::Base
  before_create :create_remember_token

  validates :goal, presence: true

  def Goal.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Goal.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = Goal.encrypt(Goal.new_remember_token)
    end
end
