class BeeswaxCampaignJob < ApplicationJob
	queue_as :beeswax_actions

	# rescue_from(ArgumentError) do
	#   retry_job wait: 2.minutes, queue: :beeswax_actions_retry
	# end

	def perform(campaign)
	  Beeswax.authenticate
		create_on_beeswax(campaign)
  end


  def create_on_beeswax(campaign)
	  response = Beeswax::Campaign.create(
			  advertiser_id: campaign.advertiser.beeswax_id,
			  # alternative_id: campaign."",
			  campaign_name: campaign.name,
			  campaign_budget: campaign.campaign_budget,
			  daily_budget: campaign.daily_budget,
			  budget_type: campaign.budget_type,
			  # revenue_type: campaign."",
			  # revenue_amount: campaign."",
			  # pacing: campaign."",
			  start_date: campaign.start_date,
			  # end_date: campaign.end_date,
			  frequency_cap: campaign.frequency_cap,
			  notes: campaign.notes,
			  active: true )
	  if response[:id].present?
		  campaign.beeswax_id = response[:id]
		  campaign.save
	  else
		  log_failure(response)
	  end
  end

  # def activate_campaign
	 #  response = Beeswax::Campaign.create(
		# 	  advertiser_id: advertiser.beeswax_id,
		# 	  active: true )
	 #  handle_response(response)
  # end

end
