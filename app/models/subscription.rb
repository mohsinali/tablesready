class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :coupon
  belongs_to :plan

  scope :trial, -> {where(subs_type: Yetting.subscription_types["trial"])}
  scope :walkin, -> {where(subs_type: Yetting.subscription_types["walkin"])}
  scope :marketing, -> {where(subs_type: Yetting.subscription_types["marketing"])}

end
