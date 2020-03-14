class UserSerializer < ActiveModel::Serializer
  has_many :events
  attributes :id, :first_name, :last_name
end
