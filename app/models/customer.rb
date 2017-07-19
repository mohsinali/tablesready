class Customer < ApplicationRecord
  belongs_to :restaurant
  has_many :bookings
  scope :by_phone_and_restaurant , ->(phone,restaurant) {where(restaurant: restaurant,phone: phone)}
end
