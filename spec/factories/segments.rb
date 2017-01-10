# == Schema Information
#
# Table name: segments
#
#  id               :integer          not null, primary key
#  beeswax_id       :integer
#  segment_name     :string
#  active           :boolean
#  alternative_id   :string
#  campaign_id      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  audience         :integer
#  audience_count   :integer
#  manual_image_src :string
#

FactoryGirl.define do
  factory :segment do
    segment_name "test_segment"
    alternative_id "test_seg_alt_id"

    audience 0
    active true
    campaign

	  factory :beeswax_segment do
		  beeswax_id 5528
	  end
  end
end
