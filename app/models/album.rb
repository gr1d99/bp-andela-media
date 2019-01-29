class Album < ApplicationRecord
  acts_as_taggable_on :events, :tags
  acts_as_paranoid

  # default scope
  # constants
  TITLE_REGEXP = /\A[A-Za-z0-9 ]+\z/.freeze

  # associations
  has_and_belongs_to_many :user_groups
  belongs_to :center

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

  def self.search(query)
    where("title ILIKE ?", "%#{query}%") | search_tag(query)
  end

  def self.search_tag(name)
    tagged_with(name, wild: true, any: true)
  end
end
