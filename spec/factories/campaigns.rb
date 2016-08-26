# == Schema Information
#
# Table name: campaigns
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  advertiser_id :integer
#  name          :string           not null
#  start_date    :datetime
#  end_date      :datetime
#
# Indexes
#
#  index_campaigns_on_advertiser_id  (advertiser_id)
#

FactoryGirl.define do
  factory :campaign do
    sequence(:name) { |x| "campaign_#{x}" }

	  advertiser
  end
end
