module User::Friend
  extend ActiveSupport::Concern

  def follow(other_user)
    active_relation_users << other_user if !following?(other_user) && !friend?(other_user)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id)&.destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def followed?(other_user)
    followers.include?(other_user)
  end

  def friend?(other_user)
    friends.include?(other_user)
  end

  def friends
    active_relation_users & passive_relation_users
  end

  def followers
    passive_relation_users - friends
  end

  def followings
    active_relation_users - friends
  end
end
