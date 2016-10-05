require 'rails_helper'

RSpec.describe BeeswaxLineItemsJob, type: :job do
	let(:beeswax_advertiser) { create(:beeswax_advertiser) }
	let(:beeswax_segment_campaign) { create(:beeswax_segment_campaign, advertiser: beeswax_advertiser) }

	describe "create Campaign" do
		it "enqueues multiple Beeswax LineItemsJob" do
			expect{
				beeswax_segment_campaign
			}.to change{
				     line_item_jobs = ActiveJob::Base.queue_adapter.enqueued_jobs.select { |jobObj| jobObj[:job] == BeeswaxLineItemsJob }
				     line_item_jobs.count
			     }.by(LineItem.inventory_sources.count)
		end

		# context "targeting template exists" do
		# end

		context "no targeting template" do
			it "creates line_items on Beeswax" do
				line_item = create(:line_item, campaign: beeswax_segment_campaign)
				VCR.use_cassette("beeswax_line_items_create") do
					expect{
						BeeswaxLineItemsJob.perform_now(line_item)
					}.to change(line_item, :beeswax_id)
				end
			end
		end
	end
end
