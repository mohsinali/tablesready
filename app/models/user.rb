class User < ApplicationRecord
# Added by Koudoku.
  has_many :subscriptions

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

  def trial_expired?
    expired = false
    if self.in_trial and self.trial_ends_at < Time.now
      expired = true
    end
    expired
  end
end
