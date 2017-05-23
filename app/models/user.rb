class User < ApplicationRecord
# Added by Koudoku.
  has_one :subscription

  enum role: [:user, :restaurant, :admin]
  after_initialize :set_default_role, :if => :new_record?
  belongs_to :restaurant
  belongs_to :country

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
