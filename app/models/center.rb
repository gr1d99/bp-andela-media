class Center < ApplicationRecord
  has_many :albums, dependent: :restrict_with_exception

  validates :name, presence: true
end
