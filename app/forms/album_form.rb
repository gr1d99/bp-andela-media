require "reform/form/validation/unique_validator.rb"

class AlbumForm < Reform::Form
  TITLE_REGEXP = /\A[A-Za-z0-9 ]+\z/.freeze

  properties :title, :user_id, :description, :metadata, :position,
             :preferences, :tag_list

  validates :title, unique: { message: I18n.t("errors.album.unique") },
                    length: { maximum: 64 }, format: {
                      with: TITLE_REGEXP,
                      message: I18n.t("errors.album.alphanumerics")
                    },
                    presence: { message: I18n.t("errors.album.blank") }

  validates :user_id, presence: { message: I18n.t("errors.album.blank") }

  collection :user_groups, populate_if_empty: UserGroup do
    properties :name, :emails

    validates :name, presence: { message: I18n.t("errors.album.blank") },
                     unique: { message: I18n.t("errors.album.unique") }
  end
end
