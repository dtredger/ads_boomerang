require 'rails_helper'

RSpec.describe BeeswaxAdvertiserJob, type: :job do
	describe "create Advertiser" do
		it "enqueues Beeswax AdvertiserJob" do
			expect{
				create(:advertiser)
			}.to enqueue_job(BeeswaxAdvertiserJob)
		end

		it "creates advertiser on Beeswax" do
			VCR.use_cassette("beeswax_advertiser_create") do
				advertiser = create(:advertiser)
				expect{
					BeeswaxAdvertiserJob.perform_now(advertiser)
				}.to change(advertiser, :beeswax_id)
			end
		end
	end
end
