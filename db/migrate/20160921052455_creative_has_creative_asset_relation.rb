class CreativeHasCreativeAssetRelation < ActiveRecord::Migration[5.0]
  def change
		remove_column :creatives, :creative_asset
		remove_column :creatives, :beeswax_creative_asset_id

		add_column :creatives, :creative_asset_id, :integer
  end
end
