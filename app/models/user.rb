class User < ApplicationRecord
    has_secure_password

    has_many :events
    has_many :joined_events, through: :user_events, source: :events

    has_many :requests, foreign_key: :receiver_id, class_name: 'FriendRequest'
    has_many :pending_friends, foreign_key: :requestor_id, class_name: 'FriendRequest'

    has_many :friendships, dependent: :destroy
    has_many :friends,through: :friendships

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, uniqueness: true
    
end
