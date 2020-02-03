class User < ApplicationRecord
    has_secure_password
    has_many :events
    has_many :joined_events, through: :user_events, source: :events
end
