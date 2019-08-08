class CreateBanks < ActiveRecord::Migration[5.2]
  def change
    create_table :banks do |t|
      t.string :name, limit: 25, null: false
      t.string :code, limit: 25, null: false
    end
  end
end
