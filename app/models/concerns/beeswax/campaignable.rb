require 'beeswax/base'

module Beeswax
	module Campaignable
		extend ActiveSupport::Concern

		included do
			after_commit :sync_beeswax_campaign
		end

		def sync_beeswax_campaign
			if beeswax_id.present?
				# TODO - update_on_beeswax
			else
				BeeswaxCampaignJob.perform_later(self)
			end
		end

	end
end

