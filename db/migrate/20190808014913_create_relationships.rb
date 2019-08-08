class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :following_user, foreign_key: { to_table: :users }, null: false
      t.references :followed_user, foreign_key: { to_table: :users }, null: false
      t.timestamps null: false
    end
  end
end
