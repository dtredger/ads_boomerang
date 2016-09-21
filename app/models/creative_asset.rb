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

class CreativeAsset < ApplicationRecord
	default_scope { order('created_at DESC') }

	include Beeswax::CreativeAssetable

	mount_uploader :mounted_asset, CreativeAssetUploader

	VALID_DIMENSIONS = [ [160,600], [728,90], [300,250], [300,600] ]

	validate :validate_dimensions

	belongs_to :advertiser

	has_many :creatives #, foreign_key: "creative_asset_id"


	private

		def validate_dimensions
			unless VALID_DIMENSIONS.include?([self.width, self.height])
				errors.add(:creative_asset, message: "Please choose different image dimensions")
			end
		end

end
