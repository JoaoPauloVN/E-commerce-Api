class Coupon < ApplicationRecord
  validates :code, presence: true, uniqueness: { case_sentivive: false }
  validates :status, presence: true
  validates :discount_value, presence: true, numericality: { greater_than: 0 }
  validates :due_date, presence: true
end
