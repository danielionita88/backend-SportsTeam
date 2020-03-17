class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :time, :date, :details, :user_id, :created_at
end
