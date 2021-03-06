class AlbumSerializer < ActiveModel::Serializer
  attributes :title, :description, :user_id, :metadata, :preferences,
             :user_groups, :tags, :position, :events, :created_at, :updated_at,
             :center_id

  belongs_to :center
end
