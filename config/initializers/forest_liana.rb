ForestLiana.env_secret = ENV["FOREST_SECRET_KEY"]
ForestLiana.auth_secret = ENV["FOREST_AUTH_KEY"]
ForestLiana.integrations = {
		stripe: {
				api_key: ENV["STRIPE_SECRET_KEY"],
				mapping: 'SubscriptionPlan.stripe_id'
		},
		intercom: {
				app_id: ENV["INTERCOM_APP_ID"],
				api_key: ENV["INTERCOM_API_KEY"],
				mapping: 'Advertiser'
		}
}

# "Payola::Sale.stripe_id"