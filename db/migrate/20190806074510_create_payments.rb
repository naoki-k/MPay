class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true, null: false
      t.integer :type, limit: 2, null: false
      t.string :number, limit: 255, null: false
      t.boolean :is_active, null: false, default: false
      t.index :type
      t.timestamps null: false
    end
  end
end
