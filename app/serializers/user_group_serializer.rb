class UserGroupSerializer < ActiveModel::Serializer
  type :user_groups

  attributes :id, :name, :emails, :created_at, :updated_at
end
