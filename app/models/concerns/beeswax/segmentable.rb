require 'beeswax/base'

module Beeswax
	module Segmentable
		extend ActiveSupport::Concern

		def authenticate_beeswax
			Beeswax.authenticate
		end

		def create_campaign_segments
			authenticate_beeswax
			create_include_segment if include_segment.nil?
			create_exclude_segment if exclude_segment.nil?
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
				segments.create(audience: :include, beeswax_id: response[:id], segment_name: "#{self.name}_include_segment")
			elsif response[:id].present? && segment_type == :exclude
				segments.create(audience: :exclude, beeswax_id: response[:id], segment_name: "#{self.name}_exclude_segment")
			else
				log_failure(response, segment_type)
			end
		end



	end
end
