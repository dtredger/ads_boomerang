class BeeswaxAdvertiserJob < ApplicationJob
  queue_as :beeswax_actions

  # rescue_from(ArgumentError) do
  #   retry_job wait: 2.minutes, queue: :beeswax_actions_retry
  # end

  def perform(advertiser)
	  Beeswax.authenticate
	  create_beeswax_advertiser(advertiser)
  end


  def create_beeswax_advertiser(advertiser)
	  response = Beeswax::Advertiser.create(
			  alternative_id: advertiser.website[0..19],
			  advertiser_name: advertiser.name,
			  attributes: advertiser.beeswax_attributes,
			  default_click_url: advertiser.default_click_url,
			  notes: advertiser.notes )
	  if response[:id].present?
		  advertiser.beeswax_id = response[:id]
			advertiser.save
	  else
		  log_failure(response)
	  end
  end

end
