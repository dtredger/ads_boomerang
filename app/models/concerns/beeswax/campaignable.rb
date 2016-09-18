require 'beeswax/base'

module Beeswax
	module Campaignable
		extend ActiveSupport::Concern

		included do
			validates_presence_of :start_date
		end

		def authenticate_beeswax
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
			handle_response(response)
		end

		def update_on_beeswax

		end

		def activate_campaign
			response = Beeswax::Campaign.create(
					advertiser_id: advertiser.beeswax_id,
					active: true )
			handle_response(response)
		end

		def deactivate_campaign
			response = Beeswax::Campaign.create(
					advertiser_id: advertiser.beeswax_id,
					active: false )
			handle_response(response)
		end

		def handle_response(response)
			if response[:id].present?
				self.beeswax_id = response[:id]
				true
			else
				log_failure(response)
				false
			end
		end


	end
end

