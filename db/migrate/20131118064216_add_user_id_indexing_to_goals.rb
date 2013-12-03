class RemoveRememberTokenToGoals < ActiveRecord::Migration
  def change
    add_column    :goals, :user_id, :integer
    add_index     :goals, [:user_id, :created_at]
  end
end
