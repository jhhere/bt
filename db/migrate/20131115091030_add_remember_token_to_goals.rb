class AddRememberTokenToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :remember_token, :string
    add_index  :goals, :remember_token
  end
end
