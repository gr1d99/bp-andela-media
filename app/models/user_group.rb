class UserGroup < ApplicationRecord
  validates :name,
    presence: true,
    uniqueness: true,
    length: { maximum: 32 }
end
