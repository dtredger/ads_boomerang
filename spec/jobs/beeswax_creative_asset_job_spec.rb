require 'rails_helper'

RSpec.describe BeeswaxCreativeAssetJob, type: :job do
	let(:beeswax_advertiser) { create(:beeswax_advertiser) }
	let(:beeswax_segment_campaign) { create(:beeswax_segment_campaign, advertiser: beeswax_advertiser) }

	describe "create CreativeAsset" do
		it "enqueues Beeswax CreativeAssetJob" do
			expect{
				create(:creative_asset)
			}.to enqueue_job(BeeswaxCreativeAssetJob)
		end

		it "creates creative asset on Beeswax" do
			asset = create(:creative_asset, advertiser: beeswax_advertiser)
			VCR.use_cassette("beeswax_creative_assets_create", record: :new_episodes) do
				expect{
					BeeswaxCreativeAssetJob.perform_now(asset)
				}.to change(asset, :beeswax_asset_id)
			end
		end
	end
end
