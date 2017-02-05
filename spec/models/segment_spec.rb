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
#  audience_type    :integer
#  manual_image_src :string
#  audience_history :json
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

	describe "seven_day_history" do
		it "returns max seven key/val pairs" do
			segment.update(audience_history: {
					               "#{(Date.today-8).to_s}":100,
					               "#{(Date.today-7).to_s}":200,
					               "#{(Date.today-6).to_s}":300,
					               "#{(Date.today-5).to_s}":400,
					               "#{(Date.today-4).to_s}":550,
					               "#{(Date.today-3).to_s}":660,
					               "#{(Date.today-2).to_s}":770,
					               "#{(Date.today-1).to_s}":880,
					               "#{Date.today.to_s}":992
			               })
			expect(segment.seven_day_history).to eq({"#{(Date.today-6).to_s}":300,
			                                         "#{(Date.today-5).to_s}":400,
			                                         "#{(Date.today-4).to_s}":550,
			                                         "#{(Date.today-3).to_s}":660,
			                                         "#{(Date.today-2).to_s}":770,
			                                         "#{(Date.today-1).to_s}":880,
			                                         "#{Date.today.to_s}":992}.as_json)
		end

		it "only returns those from last week" do
			segment.update(audience_history: {
					               "#{(Date.today-28).to_s}":100,
					               "#{(Date.today-17).to_s}":200,
					               "#{(Date.today-36).to_s}":300,
					               "#{(Date.today-5).to_s}":400,
					               "#{(Date.today-24).to_s}":550,
					               "#{(Date.today-3).to_s}":660,
					               "#{(Date.today-2).to_s}":770,
					               "#{(Date.today-1).to_s}":880,
					               "#{Date.today.to_s}":992
			               })
			expect(segment.seven_day_history).to eq({"#{(Date.today-5).to_s}":400,
			                                         "#{(Date.today-3).to_s}":660,
			                                         "#{(Date.today-2).to_s}":770,
			                                         "#{(Date.today-1).to_s}":880,
			                                         "#{Date.today.to_s}":992}.as_json)
		end
	end
end
