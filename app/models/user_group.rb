class UserGroup < ApplicationRecord
  # default scope
  # constants

  # associations
  has_and_belongs_to_many :albums

  # attr related macros
  # enums

  # validations
  validates :name,
    presence: true,
    uniqueness: true,
    length: { maximum: 32 }

  # callbacks
end
