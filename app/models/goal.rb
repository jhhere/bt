class Goal < ActiveRecord::Base
  validates :user_id, presence: true
  validates :goal, presence: true, length: { maximum: 140 }
  belongs_to :user
end
