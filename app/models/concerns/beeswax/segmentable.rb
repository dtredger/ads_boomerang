require 'beeswax/base'

module Beeswax
	module Segmentable
		extend ActiveSupport::Concern

		included do
			after_commit :create_beeswax_segments
		end


		def create_beeswax_segments
			BeeswaxSegmentsJob.perform_later(self)
		end

	end
end