require 'beeswax/base'

module Beeswax
	module LineItemable
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
			attach_targeting_template if targeting_template_id.nil?
			if beeswax_id.present?
				update_on_beeswax
			else
				create_on_beeswax
			end
		end


		def attach_targeting_template
			# http://docs.beeswax.com/docs/list-of-targeting-modules-and-keys
			targeting_object = {
					segment: [
							{ include: {segment: [campaign.include_segment_key]} },
							{ exclude: {segment: [campaign.exclude_segment_key]} }
					],
					inventory: [
							{ include: {inventory_source: [inventory_id]} }
					]
			}
			response = Beeswax::TargetingTemplate.create(
					template_name: "#{campaign.advertiser.name}_#{name}_targeting",
					alternative_id: "",
					strategy_id: strategy_id,
					targeting: targeting_object,
					active: true )
			if response[:id].present?
				self.targeting_template_id = response[:id]
				true
			else
				add_beeswax_error
				false
			end
		end

		def create_on_beeswax
			response = Beeswax::LineItem.create(beeswax_line_item_params)
			if response[:id].present?
				self.beeswax_id = response[:id]
				true
			else
				add_beeswax_error
				false
			end
		end

		def update_on_beeswax
			response = Beeswax::LineItem.create(beeswax_line_item_params)
			if response[:id].present?
				true
			else
				add_beeswax_error
				false
			end
		end


		def beeswax_line_item_params
			{
					campaign_id: campaign.beeswax_id,
					advertiser_id: campaign.advertiser.beeswax_id,
					line_item_name: name,
					alternative_id: alternative_id,
					line_item_type_id: line_item_type_id,
					targeting_template_id: targeting_template_id,
					line_item_budget: line_item_budget,
					daily_budget: daily_budget,
					budget_type: budget_type,
					bidding: bidding,
					start_date: campaign.start_date,
					notes: notes,
					active: false
			}
		end

		def present_in_beeswax
			add_beeswax_error if beeswax_id.nil?
		end

		def add_beeswax_error
			errors.add(:beeswax_id, :blank, message: "cannot be nil")
		end

	end
end


