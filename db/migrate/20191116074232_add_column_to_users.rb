class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :user_name, :string
    add_column :users, :name, :string
    add_column :users, :website, :string
    add_column :users, :introduction, :text
    add_column :users, :phone_number, :integer
    add_column :users, :sex, :integer
    add_column :users, :privider, :string
    add_column :users, :uid, :string
  end
end
