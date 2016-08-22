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
