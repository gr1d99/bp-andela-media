class User < ApplicationRecord
  # Associations
  belongs_to :role

  EMAIL_REGEXP = /\A([\w+\-].?)+@andela+(\.[a-z]+)*\.[a-z]+\z/.freeze

  # validations
  validates :email, uniqueness: { message: I18n.t("errors.user.unique") },
                    format: {
                      with: EMAIL_REGEXP,
                      message: I18n.t("errors.user.invalid_email")
                    }

  self.primary_key = :camper_id
end
