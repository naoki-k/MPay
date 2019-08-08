class CreateTrades < ActiveRecord::Migration[5.2]
  def change
    create_table :trades do |t|
      t.references :active_payment, foreign_key: { to_table: :payments }, null: false
      t.references :passive_payment, foreign_key: { to_table: :payments }, null: false
      t.references :billing, foreign_key: true
      t.string :kind, limit: 25, null: false
      t.integer :amount, null: false
      t.datetime :created_at, null: false
    end
  end
end
