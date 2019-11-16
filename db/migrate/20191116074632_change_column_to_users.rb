class ChangeColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :name, :string, null:false
    change_column :users, :user_name, :string, null:false

    add_index :users, :user_name, unique: true
  end
end
