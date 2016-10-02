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

FactoryGirl.define do
  factory :creative do
	  campaign
	  creative_asset

    sequence(:name) { |x| "creative_#{x}" }
  end
end
