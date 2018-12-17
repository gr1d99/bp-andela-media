class AlbumSerializer < ActiveModel::Serializer
  attributes :title, :description, :user_id, :metadata, :preferences,
             :user_groups, :tags, :position, :created_at, :updated_at
end
