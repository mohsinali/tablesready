class Booking < ApplicationRecord
  acts_as_paranoid
  enum status: [ :seated,:no_show,:cancelled]
  belongs_to :restaurant
end
