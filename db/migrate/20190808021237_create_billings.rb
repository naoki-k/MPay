class CreateBillings < ActiveRecord::Migration[5.2]
  def change
    create_table :billings do |t|
      t.references :sender, foreign_key: { to_table: :users }, null: false
      t.references :receiver, foreign_key: { to_table: :users }, null: false
      t.integer :amount, null: false
      t.string :content, limit: 3000
      t.timestamps null: false
    end
  end
end
