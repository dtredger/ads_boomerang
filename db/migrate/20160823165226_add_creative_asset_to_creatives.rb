class AddCreativeAssetToCreatives < ActiveRecord::Migration[5.0]
  def change
    add_column :creatives, :creative_asset, :string
  end
end
