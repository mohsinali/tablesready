class WalkIn < Booking
  after_create :set_checkin

end
