require 'beeswax/base'

module Beeswax
	module LineItemable
		extend ActiveSupport::Concern

		included do
			after_commit :sync_beeswax_line_items
		end

		def sync_beeswax_line_items
			if beeswax_id.present?
				# attach_targeting_template if targeting_template_id.nil?
				# update_on_beeswax
			else
				BeeswaxLineItemsJob.perform_later(self)
			end
		end

	end
end


