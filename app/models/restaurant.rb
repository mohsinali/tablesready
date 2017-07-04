class Restaurant < ApplicationRecord
  has_many :users,dependent: :destroy
  has_many :bookings,dependent: :destroy
  has_many :messages
  has_many :messages
  has_many :message_templates

  def user
    users.first
  end

  def customers_count
    customers.count
  end

  def customers
    bookings.unscoped.by_restaurant(self).select("distinct(phone)")
  end
end
