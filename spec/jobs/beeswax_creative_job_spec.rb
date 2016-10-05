require 'rails_helper'

RSpec.describe BeeswaxCreativeJob, type: :job do
	let(:beeswax_advertiser) { create(:beeswax_advertiser) }
	let(:beeswax_segment_campaign) { create(:beeswax_segment_campaign, advertiser: beeswax_advertiser) }
	let(:beeswax_creative_asset) { create(:beeswax_creative_asset, advertiser: beeswax_advertiser) }

	describe "create creative" do
		it "enqueues Beeswax CreativeJob" do
			expect{
				create(:creative, campaign: beeswax_segment_campaign, creative_asset: beeswax_creative_asset)
			}.to enqueue_job(BeeswaxCreativeJob)
		end

		it "creates creative on Beeswax" do
			creative = create(:creative, campaign: beeswax_segment_campaign, creative_asset: beeswax_creative_asset)
			VCR.use_cassette("beeswax_creative_create") do
				expect{
					BeeswaxCreativeJob.perform_now(creative)
				}.to change(creative, :beeswax_creative_id)
			end
		end
	end
end
