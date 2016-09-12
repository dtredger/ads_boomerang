# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "creating advertiser: advertiser_1@email.com, password:123123123"
advertiser_1 = Advertiser.create(email:"advertiser_1@email.com", password:"123123123")

puts "creating campaign for advertiser_1"

# s = Payola::Subscription.first
# g = Payola::Sale.create(email:s.email,
#                       product:s,
#                       product_type:s.class,
#                       stripe_id:s.stripe_id,
#                       card_last4:s.card_last4,
#                       card_expiration:s.card_expiration,
#                       card_type:s.card_type,
#                       amount:s.amount,
#                       stripe_customer_id:s.stripe_customer_id,
#                       owner_id:s.owner_id,
#                       stripe_token:s.stripe_token,
#                       affiliate:s.affiliate,
#                       coupon:nil,
#                       currency:s.currency,
#                       owner_type:s.owner.class,
#                       coupon:Payola::Coupon.first_or_create)

# sale = {"id":3,"email":"t+11@em.com","guid":"ammuu7","product_id":6,"product_type":"SubscriptionPlan",
# 		"created_at":"2016-09-12T19:07:59.766Z","updated_at":"2016-09-12T19:07:59.766Z","state":"finished","stripe_id":"ch_18sZhqKkbshVLuJ2ArnT5gqR","stripe_token":"invoice","card_last4":"4242","card_expiration":null,"card_type":"Visa","error":null,"amount":2999,"fee_amount":141,"coupon_id":1,"opt_in":null,"download_count":null,"affiliate_id":1,"customer_address":null,"business_address":null,"stripe_customer_id":null,"currency":"usd","signed_custom_fields":null,"owner_id":11,"owner_type":"Payola::Subscription"}

# {advertiser_id: 38522, campaign_name: "test campaign name", campaign_budget:  1000.00, daily_budget: 10.00, budget_type: "spend", start_date:  Time.now, end_date: (Time.now + 100000), notes: "test notes", active: true}

# Subscription Plans:
SubscriptionPlan.create(
		name: "basic monthly plan",
		amount: 2999.00,
		interval: "month",
		stripe_id: "basic_monthly_plan"
)
SubscriptionPlan.create(
		name: "premium monthly plan",
		amount: 5999.00,
		interval: "month",
		stripe_id: "premium_monthly_plan"
)