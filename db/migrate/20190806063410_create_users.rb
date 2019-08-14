class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :type, limit: 2, null: false
      t.string :tel, limit: 25, null: false
      t.string :name, limit: 25, null: false
      t.string :password_digest, limit: 255, null: false
      t.string :email, limit: 255
      t.index :type
      t.index :tel, unique: true
      t.timestamps null: false
    end
  end
end
