class Album < ApplicationRecord
  acts_as_taggable
  acts_as_paranoid

  # default scope
  # constants
  TITLE_REGEXP = /\A[A-Za-z0-9 ]+\z/.freeze

  # associations
  has_and_belongs_to_many :user_groups

  # attr related macros
  # enums

  # validations
  validates :user_id, presence: { message: I18n.t("errors.album.blank") }
  validates :title, presence: { message: I18n.t("errors.album.blank") },
                    uniqueness: { message: I18n.t("errors.album.unique") },
                    length: { maximum: 64 }, format: {
                      with: TITLE_REGEXP,
                      message: I18n.t("errors.album.alphanumerics")
                    }

  # callbacks
  before_create :set_position

  def set_position
    last_position = Album.order("created_at").last
    self.position = if last_position
                      last_position.increment(:position).position
                    else
                      1
                    end
  end
end
