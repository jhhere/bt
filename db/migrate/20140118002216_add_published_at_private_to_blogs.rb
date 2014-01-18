class AddPublishedAtPrivateToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :published_at, :timestamp
    add_column :blogs, :private, :boolean
  end
end