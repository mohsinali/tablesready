class Booking < ApplicationRecord
  acts_as_paranoid
  enum status: [ :seated,:no_show,:cancelled]
  belongs_to :restaurant

  scope :by_restaurant, -> (restaurant) {where(restaurant: restaurant)}

  def set_checkin flag=true
    self.update(checkin: flag)
  end
end
