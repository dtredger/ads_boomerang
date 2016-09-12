require 'beeswax/base'

module Beeswax
	module Segmentable
		extend ActiveSupport::Concern

		def authenticate_beeswax
			Beeswax.api_user = ENV["BEESWAX_API_USER"]
			Beeswax.api_password = ENV["BEESWAX_API_PASSWORD"]
			Beeswax.authenticate
		end

		def create_campaign_segments
			authenticate_beeswax
			create_include_segment if include_segment_id.nil?
			create_exclude_segment if exclude_segment_id.nil?
		end

		def create_include_segment
			response = Beeswax::Segment.create(segment_name:"#{name}_include_segment",
			                        advertiser_id: advertiser.beeswax_id )
			handle_segment_response(response, :include)
		end

		def create_exclude_segment
			response = Beeswax::Segment.create(segment_name:"#{name}_exclude_segment",
			                        advertiser_id: advertiser.beeswax_id )
			handle_segment_response(response, :exclude)
		end


		def handle_segment_response(response, segment_type)
			if response[:id].present? && segment_type == :include
				self.include_segment_id = response[:id]
			elsif response[:id].present? && segment_type == :exclude
				self.exclude_segment_id = response[:id]
			else
				log_failure(response, segment_type)
			end
		end

	end
end
