# == Schema Information
#
# Table name: subscription_plans
#
#  id         :integer          not null, primary key
#  amount     :integer
#  interval   :string
#  stripe_id  :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SubscriptionPlan < ApplicationRecord
	include Payola::Plan

	def delete
		# Not handled within Payola::Plan as Create is
		begin
			secret_key = Payola.secret_key_for_sale(self)
			stripe_plan = Stripe::Plan.retrieve(stripe_id, secret_key)
			super if stripe_plan && stripe_plan.delete
		rescue Stripe::InvalidRequestError => err
			log_failure("failure deleting SubscriptionPlan", err)
		end
	end


	def redirect_path(subscription)
		Rails.logger.debug(subscription.inspect)
		"/"
	end

	def active?
		true
	end

end

# --- Webhooks from Stripe ---
# "type"=>"customer.source.created"
# "type"=>"customer.created"
# "type"=>"plan.deleted"
# "type"=>"customer.created"
# "type"=>"invoice.created"
# "type"=>"customer.subscription.created"
# "type"=>"customer.source.created"
# "type"=>"charge.succeeded"
# "type"=>"customer.updated"
# "type"=>"invoice.payment_succeeded"