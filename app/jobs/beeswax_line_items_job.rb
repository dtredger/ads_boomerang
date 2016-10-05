class BeeswaxLineItemsJob < ApplicationJob
	queue_as :beeswax_actions

	# rescue_from(ArgumentError) do
	# 	retry_job wait: 2.minutes, queue: :beeswax_actions_retry
	# end


  def perform(line_item)
	  Beeswax.authenticate
	  attach_targeting_template(line_item) if line_item.targeting_template_id.nil?
	  create_line_item_on_beeswax(line_item)
  end


	def attach_targeting_template(line_item)
		response = Beeswax::TargetingTemplate.create(
				template_name: "#{line_item.campaign.name}_#{line_item.name}_targeting",
				alternative_id: "",
				strategy_id: line_item.strategy_id,
				targeting: line_item.targeting_object,
				active: true )
		if response[:id].present?
			line_item.targeting_template_id = response[:id]
		else
			log_failure(response)
		end
	end

	def create_line_item_on_beeswax(line_item)
		response = Beeswax::LineItem.create(
				campaign_id: line_item.campaign.beeswax_id,
				advertiser_id: line_item.campaign.advertiser.beeswax_id,
				line_item_name: line_item.name,
				alternative_id: line_item.alternative_id,
				line_item_type_id: line_item.line_item_type_id,
				targeting_template_id: line_item.targeting_template_id,
				line_item_budget: line_item.line_item_budget,
				daily_budget: line_item.daily_budget,
				budget_type: line_item.budget_type,
				bidding: line_item.bidding,
				start_date: line_item.campaign.start_date,
				notes: line_item.notes,
				active: false )
		if response[:id].present?
			line_item.beeswax_id = response[:id]
			line_item.save
		else
			log_failure(response)
		end
	end

end
