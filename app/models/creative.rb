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

  belongs_to :advertiser

end
