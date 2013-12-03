class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :invitable, :omniauth_providers => [:google_oauth2]

  has_many :goals, dependent: :destroy

  attr_accessor :guest

  def password_required?
    guest ? false : super
  end

  def email_required?
    guest ? false : super
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create(email: data["email"],
                        password: Devise.friendly_token[0,20]
                        )
    end
    user
  end

end
