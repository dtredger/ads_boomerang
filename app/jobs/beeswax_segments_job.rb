class BeeswaxSegmentsJob < ApplicationJob
	queue_as :beeswax_actions

	# rescue_from(ArgumentError) do
	#   retry_job wait: 2.minutes, queue: :beeswax_actions_retry
	# end

  def perform(campaign)
	  Beeswax.authenticate
	  create_include_segment(campaign) if campaign.include_segment.nil?
	  create_exclude_segment(campaign) if campaign.exclude_segment.nil?
  end


	def create_include_segment(campaign)
		response = Beeswax::Segment.create(
				segment_name:"#{campaign.name}_include_segment",
				advertiser_id: campaign.advertiser.beeswax_id )
		handle_segment_response(campaign, response, :include)
	end

	def create_exclude_segment(campaign)
		response = Beeswax::Segment.create(
				segment_name:"#{campaign.name}_exclude_segment",
		    advertiser_id: campaign.advertiser.beeswax_id )
		handle_segment_response(campaign, response, :exclude)
	end


	def handle_segment_response(campaign, response, segment_type)
		if response[:id].present? && segment_type == :include
			campaign.segments.create(
					audience: :include,
					beeswax_id: response[:id],
					segment_name: "#{campaign.name}_include_segment" )
		elsif response[:id].present? && segment_type == :exclude
			campaign.segments.create(
					audience: :exclude,
					beeswax_id: response[:id],
					segment_name: "#{campaign.name}_exclude_segment" )
		else
			log_failure(response, segment_type)
		end
	end

end
