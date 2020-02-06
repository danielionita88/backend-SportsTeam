class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :time, :date, :details, :user_id
end
