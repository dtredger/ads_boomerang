class SubscriptionsController < ApplicationController
	include Payola::StatusBehavior

	def new
		@plan = SubscriptionPlan.first
	end

	def create
		# do any required setup here, including finding or creating the owner object
		owner = current_advertiser # this is just an example for Devise

		byebug

		# set your plan in the params hash
		params[:plan] = SubscriptionPlan.find_by(id: params[:plan_id])

		# call Payola::CreateSubscription
		subscription = Payola::CreateSubscription.call(params, owner)

		# Render the status json that Payola's javascript expects
		render_payola_status(subscription)
	end
end
