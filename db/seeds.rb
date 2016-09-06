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

s = Payola::Subscription.first
g = Payola::Sale.create(email:s.email,
                      product:s,
                      product_type:s.class,
                      stripe_id:s.stripe_id,
                      card_last4:s.card_last4,
                      card_expiration:s.card_expiration,
                      card_type:s.card_type,
                      amount:s.amount,
                      stripe_customer_id:s.stripe_customer_id,
                      owner_id:s.owner_id,
                      stripe_token:s.stripe_token,
                      affiliate:s.affiliate,
                      coupon:nil,
                      currency:s.currency,
                      owner_type:s.owner.class,
                      coupon:Payola::Coupon.first_or_create)



# {advertiser_id: 38522, campaign_name: "test campaign name", campaign_budget:  1000.00, daily_budget: 10.00, budget_type: "spend", start_date:  Time.now, end_date: (Time.now + 100000), notes: "test notes", active: true}