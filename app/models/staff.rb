class Staff < ApplicationRecord
  belongs_to :restaurant
  validates :name, presence: true
  validates :contact, presence: true
  validates :specialization, presence: true
end
