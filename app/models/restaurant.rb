class Restaurant < ApplicationRecord
  has_many :users,dependent: :destroy
  has_many :bookings,dependent: :destroy


  def user
    users.first
  end

  def customers_count
    bookings.select("distinct(phone)").count
  end
end
