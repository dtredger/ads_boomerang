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
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  audience       :integer
#  audience_count :integer
#

FactoryGirl.define do
  factory :segment do
    type 1
    segment_name "MyString"

    active false
    campaign

	  factory :beeswax_segment do
		  beeswax_id 5528
	  end
  end
end
