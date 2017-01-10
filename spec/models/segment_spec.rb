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

require 'rails_helper'

RSpec.describe Segment, type: :model do
	let(:segment) { create(:segment) }

	describe "manual segment creation" do
		it "allows setting manual img url" do
			segment.update(manual_image_src: "http://pixel.sitescout.com/iap/b2000000000ff")
			segment.save
			segment.reload
			expect(segment.retarget_src).to eq("http://pixel.sitescout.com/iap/b2000000000ff")
		end
	end
end