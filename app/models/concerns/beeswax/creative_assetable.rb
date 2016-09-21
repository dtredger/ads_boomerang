require 'beeswax/base'

module Beeswax
	module CreativeAssetable
		extend ActiveSupport::Concern

		included do
			before_save :sync_with_beeswax
		end

		def authenticate_beeswax
			Beeswax.authenticate
		end

		def sync_with_beeswax
			authenticate_beeswax
			if self.beeswax_asset_id.present?
				update_beeswax_creative
			else
				create_beeswax_asset_base
			end
		end

		def update_beeswax_creative
			# TODO
			log_failure("update creative not implemented")
			raise "update not implemented"
		end

		def create_beeswax_asset_base
			response = Beeswax::CreativeAsset.create(
					advertiser_id: advertiser.beeswax_id,
					creative_asset_name: mounted_asset.file.original_filename,
					size_in_bytes: mounted_asset.file.size,
					active: false )
			if response[:id]
				self.beeswax_asset_id = response[:id]
				upload_file_to_beeswax(response[:id])
			else
				log_failure(response)
			end
		end

		def upload_file_to_beeswax(asset_id)
			response = Beeswax::CreativeAsset.upload(
					creative_asset_id: asset_id,
					creative_content: mounted_asset.file.to_file )
			if response[:id] && response[:id] == beeswax_asset_id
				check_beeswax_asset_metadata(response[:id])
			else
				log_failure(response)
			end
		end

		def check_beeswax_asset_metadata(beeswax_id)
			response = Beeswax::CreativeAsset.get(beeswax_id)
			if response[:active]
				self.active             = response[:active]
				self.size_bytes         = response[:size_in_bytes]
				self.beeswax_asset_path = response[:path_to_asset]
			else
				log_failure(response)
			end
		end
	end
end
