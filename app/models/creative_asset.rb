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
	include Beeswax::CreativeAssetable

	has_paper_trail
	mount_uploader :mounted_asset, CreativeAssetUploader

	default_scope { order('created_at DESC') }

	belongs_to :advertiser
	has_many :creatives, dependent: :destroy
	has_many :campaigns, through: :creatives

	VALID_DIMENSIONS = [ [160,600], [728,90], [300,250], [300,600] ]
	validate :validate_dimensions


	private

		def validate_dimensions
			unless VALID_DIMENSIONS.include?([self.width, self.height])
				errors.add(:creative_asset, message: "Please choose different image dimensions")
			end
		end

end
