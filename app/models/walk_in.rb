class WalkIn < Booking
  # set checkin to true
  after_create :set_checkin

end
