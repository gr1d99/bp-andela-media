class CenterSerializer < ActiveModel::Serializer
  attributes :name

  has_many :albums
end
