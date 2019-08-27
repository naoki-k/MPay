module Friend
  extend ActiveSupport::Concern

  def follow(user)
    active_relationships.create(followed_user_id: user.id)
  end

  def unfollow(user)
    active_relationships.find_by_id(user.id).destroy
  end

  def following?(user)
    following_users.include?(user)
  end
end
