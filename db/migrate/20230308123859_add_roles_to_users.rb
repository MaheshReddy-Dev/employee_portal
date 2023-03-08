class AddRolesToUsers < ActiveRecord::Migration[7.0]
  def change
  end
  add_column :users, :role, :integer
end
