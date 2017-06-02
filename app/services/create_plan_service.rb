class CreatePlanService

  def call
    Plan.destroy_all
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE plans_id_seq RESTART WITH 1")
    Plan.create({
      name: 'Trial',
      price: 0.00,
      interval: 'month',
      stripe_id: 'trial',
      features: "0-100 SMS",
      display_order: 0,
      plan_type: "Trial"
    })

    Plan.create({
      name: 'Basic',
      price: 49.00,
      interval: 'month',
      stripe_id: 'basic',
      features: "0-100 SMS",
      display_order: 1,
      plan_type: "Walkin"
    })

    Plan.create({
      name: 'Startup',
      highlight: true, # This highlights the plan on the pricing page.
      price: 49.00,
      interval: 'month',
      stripe_id: 'startup',
      features: "101-500 SMS",
      display_order: 2,
      plan_type: "Marketing"
    })

    Plan.create({
      name: 'Bronze',
      highlight: true, # This highlights the plan on the pricing page.
      price: 79.00,
      interval: 'month',
      stripe_id: 'bronze',
      features: "501-1000 SMS",
      display_order: 3,
      plan_type: "Marketing"
    })

    Plan.create({
      name: 'Silver',
      highlight: true, # This highlights the plan on the pricing page.
      price: 140.00,
      interval: 'month',
      stripe_id: 'silver',
      features: "1001-2500 SMS",
      display_order: 4,
      plan_type: "Marketing"
    })

    Plan.create({
      name: 'Gold',
      highlight: true, # This highlights the plan on the pricing page.
      price: 280.00,
      interval: 'month',
      stripe_id: 'gold',
      features: "2501-5000 SMS",
      display_order: 5,
      plan_type: "Marketing"
    })

    Plan.create({
      name: 'Platinium',
      highlight: true, # This highlights the plan on the pricing page.
      price: 420.00,
      interval: 'month',
      stripe_id: 'platinium',
      features: "5001-7500 SMS",
      display_order: 6,
      plan_type: "Marketing"
    })

    Plan.create({
      name: 'Diamond',
      highlight: true, # This highlights the plan on the pricing page.
      price: 560.00,
      interval: 'month',
      stripe_id: 'diamond',
      features: "7501-10000 SMS",
      display_order: 7,
      plan_type: "Marketing"
    })
  end
end