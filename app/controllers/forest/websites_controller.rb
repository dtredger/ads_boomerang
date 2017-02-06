class Forest::WebsitesController < ForestLiana::ApplicationController

	def create_segments
		website_ids = forest_website_params["ids"]

		website_ids.each do |id|
			website = ::Website.find_by(id: id)
			return unless website
			campaign = website.campaign
			return unless campaign
			if campaign.include_segment.nil?
				create_segment(campaign, "add")
			end
			if campaign.exclude_segment.nil?
				create_segment(campaign, "exclude")
			end
		end
		render body: nil, status: 204
	end



	private

		def forest_website_params
			params.require('data').require('attributes')
		end

		def create_segment(campaign, type)
			campaign.segments.create(segment_name: "#{campaign.name}_#{type}_segment", audience_type: type)
		end

end
