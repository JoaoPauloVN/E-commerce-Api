class Game < ApplicationRecord
  belongs_to :system_requirement
  has_one :product, as: :productable

  validates :mode, presence: true
  validates :release_date, presence: true
  validates :developer, presence: true
end
