require 'beeswax/base'

module BeeswaxCampaign
	extend ActiveSupport::Concern

	included do
		before_validation :sync_with_beeswax

		validate :present_in_beeswax
	end

	def authenticate_beeswax
		Beeswax.api_user = ENV["BEESWAX_API_USER"]
		Beeswax.api_password = ENV["BEESWAX_API_PASSWORD"]
		Beeswax.authenticate
	end

	def sync_with_beeswax
		authenticate_beeswax
		if beeswax_id.present?
			update_on_beeswax
		else
			create_on_beeswax
		end
	end

	def create_on_beeswax
		response = Beeswax::Campaign.create(
				advertiser_id: advertiser.beeswax_id,
				# alternative_id: "",
				campaign_name: name,
				campaign_budget: campaign_budget,
				daily_budget: daily_budget,
				budget_type: budget_type,
				# revenue_type: "",
				# revenue_amount: "",
				# pacing: "",
				start_date: start_date,
				end_date: end_date,
				frequency_cap: frequency_cap,
				notes: notes,
				active: false )

		if response[:id].present?
			self.beeswax_id = response[:id]
			true
		else
			add_beeswax_error
			false
		end
	end

	def update_on_beeswax

	end

	def activate_campaign
		response = Beeswax::Campaign.create(
				advertiser_id: advertiser.beeswax_id,
				active: true )
		if response[:id].present?
			self.beeswax_id = response[:id]
			true
		else
			add_beeswax_error
			false
		end
	end

	def deactivate_campaign
		response = Beeswax::Campaign.create(
				advertiser_id: advertiser.beeswax_id,
				active: false )
		if response[:id].present?
			self.beeswax_id = response[:id]
			true
		else
			add_beeswax_error
			false
		end
	end

	def present_in_beeswax
		add_beeswax_error if beeswax_id.nil?
	end

	def add_beeswax_error
		errors.add(:beeswax_id, :blank, message: "cannot be nil")
	end

end
