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

  def booked_by
    self.restaurant.user
  end

  def auto_no_show
    if self.is_noshow_markable?
      self.notes = "#{self.notes}\nAutomarked no-show by system"
      self.no_show!
      ActionCable.server.broadcast 'bookings',
        booking: self
    else
      self.set_job_broadcast
    end
    true
  end

  def set_noshow_job
    if self.saved_change_to_attribute?(:booking_date) or self.saved_change_to_attribute?(:booking_time)
      set_job_broadcast
    end
  end



  
  # returns true/false
  # true if booking time + threshold is less than current time, otherwise false
  def is_noshow_markable?
    return true if self.no_show? # already marked as no_show
    user = self.booked_by
    threshold = user.no_show_threshold.to_i
    date = self.booking_date.strftime("%Y-%m-%d")
    time = self.booking_time.strftime("%H:%M")
    # booking time with threshold margin in user time zone
    bt = "#{date} #{time}".in_time_zone(user.time_zone) + threshold.minutes
    # current time in user time zone
    ct = Time.now.in_time_zone(user.time_zone)
    return bt < ct
  end

  def set_job_broadcast
    user = self.booked_by
    threshold = user.no_show_threshold.to_i
    date = self.booking_date.strftime("%Y-%m-%d")
    time = self.booking_time.strftime("%H:%M")
    # booking time with threshold margin in user time zone
    bt = "#{date} #{time}".in_time_zone(user.time_zone) + threshold.minutes
    puts "in set_job_broadcast: bt: #{bt} ct: #{Time.now}"
    BookingBroadcastJob.set(wait_until: bt).perform_later(self)
  end
end
