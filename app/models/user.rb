class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :goals, dependent: :destroy

  attr_accessor :guest

  def password_required?
    guest ? false : super
  end

  def email_required?
    guest ? false : super
  end

end
