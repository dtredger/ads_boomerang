# == Schema Information
#
# Table name: creatives
#
#  id                    :integer          not null, primary key
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  name                  :string           not null
#  width                 :integer
#  height                :integer
#  beeswax_creative_id   :integer
#  beeswax_preview_url   :string
#  beeswax_preview_token :string
#  creative_asset_id     :integer
#  campaign_id           :integer
#
# Indexes
#
#  index_creatives_on_campaign_id  (campaign_id)
#

class Creative < ApplicationRecord
	include Beeswax::Creativeable

	has_paper_trail

  validates_presence_of :campaign,
                        :creative_asset

	before_save :set_creative_name,
	            :set_creative_size

	belongs_to :campaign
  belongs_to :creative_asset
  has_many :line_items

	default_scope { order('created_at DESC') }

	def advertiser
		campaign.advertiser
	end

  def template_id
	  1   # Beeswax image
  end

  def creative_attributes
	  # http://docs.beeswax.com/docs/creative-attributes
		{
				# "advertiser": {
				# 		"advertiser_domain": [advertiser.domain]
				# },
				# "technical": {
				# 	"banner_mime":["image/jpg"]
				# }
		}
  end

  def creative_preview_link
		"http://stingersbx.api.beeswax.com/buzz/public/CreativePreview.php?token=#{beeswax_preview_token}"
  end

  def click_url
	  if campaign
		  campaign.click_url
	  elsif campaign.advertiser
		  campaign.advertiser.default_click_url
	  else
			"http://fallback-url.com"
	  end
  end

	private

		def set_creative_name
			self.name = "(#{campaign.name}) - #{creative_asset.name}"
		end

		def set_creative_size
			self.height = creative_asset.height
			self.width = creative_asset.width
		end


end


# TODO - use state-machine to monitor sync and asset-upload status
# include AASM
#
# aasm column: 'state', skip_validation_on_save: true do
# 	state :pending, initial: true
# 	state :processing
# 	state :finished
# 	state :errored
# 	state :refunded
#
# 	event :process, after: :charge_card do
# 		transitions from: :pending, to: :processing
# 	end
#
# 	event :finish, after: :instrument_finish do
# 		transitions from: :processing, to: :finished
# 	end
#
# 	event :fail, after: :instrument_fail do
# 		transitions from: [:pending, :processing], to: :errored
# 	end
#
# 	event :refund, after: :instrument_refund do
# 		transitions from: :finished, to: :refunded
# 	end
# end
