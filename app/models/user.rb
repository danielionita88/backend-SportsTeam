class User < ApplicationRecord
    has_secure_password
    has_many :events
    has_many :joined_events, through: :user_events, source: :events
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, uniqueness: true
    
end
