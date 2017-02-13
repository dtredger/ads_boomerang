# == Schema Information
#
# Table name: creative_assets
#
#  id                     :integer          not null, primary key
#  advertiser_id          :integer
#  name                   :string
#  width                  :integer
#  height                 :integer
#  mounted_asset          :string
#  beeswax_asset_id       :integer
#  beeswax_alternative_id :string
#  notes                  :string
#  active                 :boolean
#  size_bytes             :integer
#  beeswax_asset_path     :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Forest::CreativeAsset
	include ForestLiana::Collection

	collection :creative_assets

end
