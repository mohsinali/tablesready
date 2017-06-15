class Booking < ApplicationRecord
  acts_as_paranoid
  enum status: [ :seated,:no_show,:cancelled]
  belongs_to :restaurant

  scope :by_restaurant, -> (restaurant) {where(restaurant: restaurant)}
  scope :created, -> {where(status: nil)}
  validates :booking_date,:booking_time,:size,:party_name,:restaurant_id,presence: true

  def set_checkin flag=true
    self.update(checkin: flag)
  end
end
