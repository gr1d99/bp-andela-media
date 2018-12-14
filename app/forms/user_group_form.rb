require "reform/form/validation/unique_validator"

class UserGroupForm < Reform::Form
  properties :name, :emails

  validates :name, presence: true, unique: true
end
