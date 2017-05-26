class Plan < ApplicationRecord
  has_many :subscriptions

  def self.get_plan plan_id
    Plan.find_by(stripe_id: plan_id)
  end
  
end
