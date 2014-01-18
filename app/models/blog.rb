class Blog < ActiveRecord::Base
  belongs_to :user
  scope :published, -> { where('published_at < ?', Time.now) }
end
