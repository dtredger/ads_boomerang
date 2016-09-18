# == Schema Information
#
# Table name: segments
#
#  id             :integer          not null, primary key
#  beeswax_id     :integer
#  segment_name   :string
#  active         :boolean
#  alternative_id :string
#  campaign_id    :integer
#  segment_count  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  audience       :integer
#

FactoryGirl.define do
  factory :segment do
    type 1
    beeswax_id 1
    segment_name "MyString"
    active false
    alternative_id "MyString"
    campaign_id 1
    segment_count 1
  end
end
