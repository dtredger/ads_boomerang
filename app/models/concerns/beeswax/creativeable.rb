require 'beeswax/base'

module Beeswax
	module Creativeable
		extend ActiveSupport::Concern

		included do
			after_save :sync_with_beeswax
		end

		def authenticate_beeswax
			Beeswax.authenticate
		end

		def sync_with_beeswax
			authenticate_beeswax
			byebug

			if beeswax_creative_id.present?
				update_beeswax_creative
			else
				create_beeswax_creative(beeswax_creative_asset_id)
				set_creative_thumbnail(beeswax_creative_id)
			end
		end

		def update_beeswax_creative
			# TODO
		end

		def create_beeswax_creative(creative_asset_id)
			response = Beeswax::Creative.create(
					advertiser_id: advertiser.beeswax_id,
					creative_name: name,
					creative_type: :banner,
					width: width,
					height: height,
					secure: false,
					click_url: click_url,
					creative_assets: [creative_asset_id],
					creative_content: creative_attributes,
					creative_template_id: template_id,
					active: true )
			if response[:id]
				self.beeswax_creative_id = response[:id]
			else
				log_failure(response)
			end
		end

		def set_creative_thumbnail(beeswax_creative_id)
			response = Beeswax::Creative.get(beeswax_creative_id)
			if response[:creative_thumbnail_url] or response[:preview_token]
				self.beeswax_preview_url = response[:creative_thumbnail_url]
				self.beeswax_preview_token = response[:preview_token]
			else
				log_failure(response)
			end
		end

	end
end
