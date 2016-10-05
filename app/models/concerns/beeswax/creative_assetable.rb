require 'beeswax/base'

module Beeswax
	module CreativeAssetable
		extend ActiveSupport::Concern

		included do
			after_commit :sync_with_beeswax
		end


		def sync_with_beeswax
			if self.beeswax_asset_id.present?
				# update_beeswax_creative
			else
				BeeswaxCreativeAssetJob.perform_later(self)
			end
		end

		def update_beeswax_creative
			# TODO - when the job saves the creative, that counts as an update ...
			log_failure("update creative not implemented")
			raise "update not implemented"
			# authenticate_beeswax
		end
	end
end
