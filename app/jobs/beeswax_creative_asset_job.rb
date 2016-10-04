class BeeswaxCreativeAssetJob < ApplicationJob
  queue_as :beeswax_actions

  def perform(asset)
	  Beeswax.authenticate
    create_beeswax_asset_base(asset)
  end

  def create_beeswax_asset_base(asset)
	  response = Beeswax::CreativeAsset.create(
			  advertiser_id: asset.advertiser.beeswax_id,
			  creative_asset_name: asset.mounted_asset.file.original_filename,
			  size_in_bytes: asset.mounted_asset.file.size,
			  active: false )
	  if response[:id]
		  asset.beeswax_asset_id = response[:id]
		  upload_file_to_beeswax(asset, response[:id])
	  else
		  log_failure(response)
	  end
  end

  def upload_file_to_beeswax(asset, remote_asset_id)
	  response = Beeswax::CreativeAsset.upload(
			  creative_asset_id: remote_asset_id,
			  creative_content: asset.mounted_asset.file.to_file )
	  if response[:id] && response[:id] == asset.beeswax_asset_id
		  check_beeswax_asset_metadata(asset, response[:id])
	  else
		  log_failure(response)
	  end
  end

  def check_beeswax_asset_metadata(asset, beeswax_id)
	  response = Beeswax::CreativeAsset.get(beeswax_id)
	  if response[:active]
		  asset.active             = response[:active]
		  asset.size_bytes         = response[:size_in_bytes]
		  asset.beeswax_asset_path = response[:path_to_asset]
			asset.save
	  else
		  log_failure(response)
	  end
  end
end
