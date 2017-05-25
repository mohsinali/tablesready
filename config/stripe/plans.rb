# This file contains descriptions of all your stripe plans

# Example
# Stripe::Plans::PRIMO #=> 'primo'

# Stripe.plan :primo do |plan|
#
#   # plan name as it will appear on credit card statements
#   plan.name = 'Acme as a service PRIMO'
#
#   # amount in cents. This is 6.99
#   plan.amount = 699
#
#   # currency to use for the plan (default 'usd')
#   plan.currency = 'usd'
#
#   # interval must be either 'week', 'month' or 'year'
#   plan.interval = 'month'
#
#   # only bill once every three months (default 1)
#   plan.interval_count = 3
#
#   # number of days before charging customer's card (default 0)
#   plan.trial_period_days = 30
# end

# Once you have your plans defined, you can run
#
#   rake stripe:prepare
#
# This will export any new plans to stripe.com so that you can
# begin using them in your API calls.

Stripe.plan :basic do |plan|
  plan.name = 'Basic'
  plan.amount = 4900 # $49.00
  plan.interval = 'month'
end

Stripe.plan :startup do |plan|
  plan.name = 'Startup'
  plan.amount = 4900 # $49.00
  plan.interval = 'month'
end

Stripe.plan :bronze do |plan|
  plan.name = 'Bronze'
  plan.amount = 7900 # $79.00
  plan.interval = 'month'
end

Stripe.plan :silver do |plan|
  plan.name = 'Silver'
  plan.amount = 14000 # $140.00
  plan.interval = 'month'
end

Stripe.plan :gold do |plan|
  plan.name = 'Gold'
  plan.amount = 28000 # $280.00
  plan.interval = 'month'
end

Stripe.plan :platinium do |plan|
  plan.name = 'Platinium'
  plan.amount = 42000 # $420.00
  plan.interval = 'month'
end

Stripe.plan :diamond do |plan|
  plan.name = 'Diamond'
  plan.amount = 56000 # $560.00
  plan.interval = 'month'
end
