class Role < ApplicationRecord
  # Associations
  has_many :users, dependent: :destroy

  # validations
  validates :name, presence: { message: I18n.t("errors.role.blank") },
                   uniqueness: { message: I18n.t("errors.role.unique") }
end
