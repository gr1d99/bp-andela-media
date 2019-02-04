class User < ApplicationRecord
  # Associations
  belongs_to :role

  EMAIL_REGEXP = /\A([\w+\-].?)+@andela+(\.[a-z]+)*\.[a-z]+\z/.freeze
  NAME_REGEXP = /\A[a-zA-Z]+\z/.freeze

  # validations
  validates :email, uniqueness: { message: I18n.t("errors.user.unique") },
                    format: {
                      with: EMAIL_REGEXP,
                      message: I18n.t("errors.user.invalid_email")
                    }
  validates :first_name, format: { with: NAME_REGEXP,
                                   message: I18n.t(
                                     "errors.user.invalid_first_name",
                                   ) }
  validates :last_name, format: { with: NAME_REGEXP,
                                  message: I18n.t(
                                    "errors.user.invalid_last_name",
                                  ) }
end
