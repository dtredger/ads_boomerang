require 'rails_helper'

RSpec.describe BeeswaxCampaignJob, type: :job do
	let(:beeswax_advertiser) { create(:beeswax_advertiser) }

	describe "create Campaign" do
		it "enqueues Beeswax CampaignJob" do
			expect{
				create(:campaign)
			}.to enqueue_job(BeeswaxCampaignJob)
		end

		it "creates campaign on Beeswax" do
			VCR.use_cassette("beeswax_campaign_create") do
				campaign = create(:campaign, advertiser: beeswax_advertiser)
				expect{
					BeeswaxCampaignJob.perform_now(campaign)
				}.to change(campaign, :beeswax_id)
			end
		end
	end

end
