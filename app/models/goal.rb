class Goal < ActiveRecord::Base
  validates :user_id, presence: true
  validates :goal, presence: true, length: { maximum: 140 }
  validates_uniqueness_of :goal

  belongs_to :user

  before_create :add_position_number

  def add_position_number
    self.position ||= (1 + users_last_goal.position.to_i if users_last_goal) || 0
  end

  def user_goals
    Goal.where("user_id = ?", user_id)
  end

  def users_last_goal
    user_goals.last
  end

end
