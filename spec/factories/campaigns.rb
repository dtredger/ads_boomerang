# == Schema Information
#
# Table name: campaigns
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  advertiser_id      :integer
#  name               :string           not null
#  start_date         :datetime
#  end_date           :datetime
#  alternative_id     :string
#  campaign_budget    :float
#  daily_budget       :float
#  budget_type        :integer
#  revenue_type       :integer
#  revenue_amount     :float
#  pacing             :integer
#  notes              :string
#  active             :boolean
#  beeswax_id         :integer
#  include_segment_id :integer
#  exclude_segment_id :integer
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
