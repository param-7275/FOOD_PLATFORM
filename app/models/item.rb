class Item < ApplicationRecord
  belongs_to :restaurant
  has_one_attached :image
  has_many :orders
end
