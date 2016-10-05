require 'beeswax/base'

module Beeswax
	module Advertisable
		extend ActiveSupport::Concern

		included do
			after_commit :save_beeswax_advertiser
		end

		def save_beeswax_advertiser
			if self.beeswax_id.nil?
				BeeswaxAdvertiserJob.perform_later(self)
			else
				# TODO
				# update_beeswax_advertiser
			end
		end

	end
end
