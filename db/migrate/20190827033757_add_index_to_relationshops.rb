class AddIndexToRelationshops < ActiveRecord::Migration[5.2]
  def change
    add_index :relationships, [:following_user_id, :followed_user_id], unique: true
  end
end
