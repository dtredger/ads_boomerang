# == Schema Information
#
# Table name: campaigns
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  advertiser_id :integer
#  name          :string           not null
#
# Indexes
#
#  index_campaigns_on_advertiser_id  (advertiser_id)
#

FactoryGirl.define do
  factory :campaign do
    
  end
end
