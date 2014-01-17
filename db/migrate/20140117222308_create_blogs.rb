class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :body
      t.string :topics
      t.references :user

      t.timestamps
    end
  end
end
