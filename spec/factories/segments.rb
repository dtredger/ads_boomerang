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

    audience_type 0
    active true
    campaign

	  factory :beeswax_segment do
		  beeswax_id 5528
	  end

	  factory :segment_with_history do
		  audience_history { {
			  "#{(Date.today-8).to_s}":100,
			  "#{(Date.today-7).to_s}":200,
			  "#{(Date.today-6).to_s}":300,
			  "#{(Date.today-5).to_s}":400,
			  "#{(Date.today-4).to_s}":550,
			  "#{(Date.today-3).to_s}":660,
			  "#{(Date.today-2).to_s}":770,
			  "#{(Date.today-1).to_s}":880,
			  "#{Date.today.to_s}":992
		  } }
	  end
  end
end
