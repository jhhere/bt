class Goal < ActiveRecord::Base
  validates :user_id, presence: true
  validates :goal, presence: true, length: { maximum: 140 }
  validates_uniqueness_of :goal

  belongs_to :user
end
