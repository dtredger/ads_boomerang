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

	def redirect_path(subscription)
		Rails.logger.debug(subscription)
		"/"
	end

	def active?
		true
	end
end
