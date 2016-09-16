Payola.configure do |config|
	config.secret_key = ENV["STRIPE_SECRET_KEY"]
	config.publishable_key = ENV["STRIPE_PUBLISHABLE_KEY"]

	config.support_email = ENV["ADMIN_EMAIL"]
  # Example subscription:
  #
  # config.subscribe 'payola.package.sale.finished' do |sale|
  #   EmailSender.send_an_email(sale.email)
  # end
	config.send_email_for :receipt,
	                      :refund,
	                      :admin_receipt,
	                      :admin_dispute,
	                      :admin_refund,
	                      :admin_failure
  #
  # In addition to any event that Stripe sends, you can subscribe
  # to the following special payola events:
  #
  #  - payola.<sellable class>.sale.finished
  #  - payola.<sellable class>.sale.refunded
  #  - payola.<sellable class>.sale.failed
  #
  # These events consume a Payola::Sale, not a Stripe::Event
  #
  # Example charge verifier:
  #
  # config.charge_verifier = lambda do |sale|
  #   raise "Nope!" if sale.email.includes?('yahoo.com')
  # end

	# # --- event will be a Payola::Subscription
	# config.charge_verifier = lambda do |event|
	# 	true
	# end
	#
	# config.subscribe 'invoice.payment_succeeded' do |event|
	# end

  # Keep this subscription unless you want to disable refund handling
  config.subscribe 'charge.refunded' do |event|
    sale = Payola::Sale.find_by(stripe_id: event.data.object.id)
    sale.refund!
  end

	# config.subscribe('payola.subscription.active') do |sub|
	# 	advertiser = Advertiser.find_by(email: sub.email)
	#
	# 	Rails.logger.debug "********************************"
	# 	Rails.logger.debug sub
	# 	Rails.logger.debug advertiser
	# 	Rails.logger.debug "********************************"
	#
	# 	if advertiser.nil?
	# 		raw_token, enc_token = Devise.token_generator.generate(Advertiser, :reset_password_token)
	# 		password = SecureRandom.hex(32)
	#
	# 		advertiser = Advertiser.create!(
	# 				email: sub.email,
	# 				password: password,
	# 				password_confirmation: password,
	# 				reset_password_token: enc_token,
	# 				reset_password_sent_at: Time.now
	# 		)
	# 		# TODO - this would bill someone not already in database, then email
	# 		# WhateverYourPasswordMailerIsNamed.whatever_the_mail_method_is(advertiser, raw_token).deliver
	# 	end
	# 	sub.owner = advertiser
	# 	sub.save!
	# end


end

# Not required if belongs_to is optional in application.rb
# require 'extensions/payola/sale'
# Payola::Sale.include(Extensions::Payola::Sale)