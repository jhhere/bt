class RemoveRememberTokenToGoals < ActiveRecord::Migration
  def change
    remove_column :goals, :remember_token, :string
    add_column    :goals, :user_id, :integer
    add_index     :goals, [:user_id, :created_at]
  end
end
