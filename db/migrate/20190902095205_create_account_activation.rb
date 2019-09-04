class CreateAccountActivation < ActiveRecord::Migration[5.2]
  def change
    create_table :account_activations do |t|
      t.references :user, foreign_key: true, null: false
      t.boolean :activated, null: false, default: false
      t.string :digest
      t.timestamps null: false
    end
  end
end
