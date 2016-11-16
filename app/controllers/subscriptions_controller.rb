class SubscriptionsController < ApplicationController
	include Payola::StatusBehavior

	def new
		@plans = SubscriptionPlan.all
	end

	def create
		owner = current_advertiser
		subscription_options = subscription_params.merge(
				plan: select_plan,
		    affiliate: select_affiliate )

		# call Payola::CreateSubscription
		subscription = Payola::CreateSubscription.call(subscription_options, owner)

		# Render the status json that Payola's javascript expects
		render_payola_status(subscription)
	end

	def subscription_params
		params.permit(:utf8, :authenticity_token, :plan_type, :plan_id, :stripeToken,
		             :stripeEmail, :coupon, :quantity, :controller)
	end

	private

		def select_plan
			subscription_params[:plan_type].classify.constantize.find_by(
					id: subscription_params[:plan_id])
		end

		def select_affiliate
			# Affiliate required, but not currently used
			Payola::Affiliate.first_or_create(email:ENV["ADMIN_EMAIL"])
		end
end