class Friendship < ApplicationRecord

  belongs_to :user, foreign_key: :friend_id

  after_create do |f|
    friendship = Friendship.find_by(friend_id: f.user_id)
    if !friendship
      Friendship.create!(user_id: f.friend_id, friend_id: f.user_id)
    end
  end

  after_destroy do |f|
    reciprocal=Friendship.find_by(friend_id: f.user_id)
    reciprocal.destroy unless reciprocal.nil?
  end

end
