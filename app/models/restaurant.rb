class Restaurant < ApplicationRecord
  belongs_to :owner
  has_many :items, dependent: :destroy
  has_many :staff, dependent: :destroy
end
