ForestLiana.secret_key = ENV["FOREST_SECRET_KEY"]
ForestLiana.auth_key = ENV["FOREST_AUTH_KEY"]
ForestLiana.integrations = {
		stripe: {
				api_key: ENV["STRIPE_SECRET_KEY"],
				mapping: 'SubscriptionPlan.stripe_id'
		}
}

# "Payola::Sale.stripe_id"