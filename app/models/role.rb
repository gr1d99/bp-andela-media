class Role < ApplicationRecord
  # Associations
  has_many :users, dependent: :destroy

  # validations
  validates :role, presence: { message: I18n.t("errors.role.blank") }
end
