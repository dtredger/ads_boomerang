# == Schema Information
#
# Table name: creatives
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  advertiser_id  :integer
#  name           :string           not null
#  creative_asset :string
#  width          :integer
#  height         :integer
#
# Indexes
#
#  index_creatives_on_advertiser_id  (advertiser_id)
#

class Creative < ApplicationRecord
  mount_uploader :creative_asset, CreativeAssetUploader

  validates_presence_of :name
  # validate :iab_sizes
  # IAB_DEFAULT_SIZES = [ [160,600], [728,90], [300,250], [300,600] ]


  belongs_to :advertiser

  has_many :line_items

	private

		# def iab_sizes
		# 	unless IAB_DEFAULT_SIZES.include?([self.width, self.height])
		# 		errors.add(:creative_asset, message: "Please choose different image dimensions")
		# 	end
		# end

end

