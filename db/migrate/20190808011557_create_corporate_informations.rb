class CreateCorporateInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :corporate_informations do |t|
      t.references :user, foreign_key: true, null: false
      t.string :address, limit: 255, null: false
      t.string :detail, limit: 65535
      t.timestamps null: false
    end
  end
end
