class CreateProfileImages < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_images do |t|
      t.references :user, foreign_key: true, null: false
      t.text :image, null: false
      t.timestamps null: false
    end
  end
end
