class Event < ApplicationRecord
    belongs_to :user
    has_many :user_events
end
