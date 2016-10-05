require 'rails_helper'

RSpec.describe BeeswaxSegmentsJob, type: :job do
	let(:beeswax_advertiser) { create(:beeswax_advertiser) }

	describe "create Campaign" do
		it "enqueues Beeswax SegmentJob" do
			expect{
				create(:campaign)
			}.to enqueue_job(BeeswaxSegmentsJob)
		end

		it "creates two segments on Beeswax" do
			campaign = create(:beeswax_campaign, advertiser: beeswax_advertiser)
			VCR.use_cassette("beeswax_segments_create") do
				expect{
					BeeswaxSegmentsJob.perform_now(campaign)
				}.to change{
					     campaign.segments.count
				     }.by(2)
			end
		end
	end
end
