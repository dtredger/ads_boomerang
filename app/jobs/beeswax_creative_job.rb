class BeeswaxCreativeJob < ApplicationJob
  queue_as :beeswax_actions

  # rescue_from(ArgumentError) do
  #   retry_job wait: 2.minutes, queue: :beeswax_actions_retry
  # end

  def perform(creative)
    Beeswax.authenticate
    create_beeswax_creative(creative)
  end


	def create_beeswax_creative(creative)
		response = Beeswax::Creative.create(
				advertiser_id: creative.advertiser.beeswax_id,
				creative_name: creative.name,
				creative_type: :banner,
				width: creative.width,
				height: creative.height,
				secure: false,
				click_url: creative.click_url,
				creative_assets: [creative.creative_asset.beeswax_asset_id],
				creative_content: creative.creative_attributes,
				creative_template_id: creative.template_id,
				active: true )
		if response[:id]
			creative.beeswax_creative_id = response[:id]
			set_preview_url(creative)
		else
			log_failure(response)
		end
	end

	def set_preview_url(creative)
		response = Beeswax::Creative.get(creative.beeswax_creative_id)
		if response[:creative_thumbnail_url] or response[:preview_token]
			creative.beeswax_preview_url = response[:creative_thumbnail_url]
			creative.beeswax_preview_token = response[:preview_token]
			creative.save
		else
			log_failure(response)
		end
	end

end
