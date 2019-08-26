class AddUserCodeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :code, :string, limit: 25
    add_index :users, :code, unique: true
  end
end
