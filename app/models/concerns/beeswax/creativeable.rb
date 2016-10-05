require 'beeswax/base'

module Beeswax
	module Creativeable
		extend ActiveSupport::Concern

		included do
			after_commit :sync_with_beeswax
		end

		def sync_with_beeswax
			if beeswax_creative_id.present?
				# update_beeswax_creative(self)
			else
				BeeswaxCreativeJob.perform_later(self)
			end
		end

		def update_beeswax_creative(creative)
			# Rails.logger.debug("Creativeable - update_beeswax_creative on:" + creative)
			# TODO
		end

	end
end
