require 'spec_helper'

RSpec.describe Beeswax::ReportQueue do
  describe :find do
    # let(:bidding) do
    #   {"bidding_strategy": "cpm", "values": {"cpm_bid":1.12} }
    # end

    it "should raise error if :report_id is not present" do
      expect {
        Beeswax::ReportQueue.find(report_id: nil)
      }.to raise_error(BeeswaxError, 'Beeswax::ReportQueue.find -> :report_id required')
    end

    it "should return just the payload portion of the response" do
      allow(Beeswax).to receive(:request).
                        with(:post, Beeswax::ReportQueue::PATH, hash_including(
                          :report_id => 1
                        )).
                        and_return({payload: {id: 1, :'0' => {cpm: 12, :'advertiser name' => 'Foo'}}})

      response = Beeswax::ReportQueue.find(
        report_id: :performance_report,
        request_details: {
          report_id: 1,
          field:  ["advertiser_id","advertiser_name"],
          metric: ["impression","clicks","CPM","CTR",
                   "spend","spend_per_conversion"],
          filter: [{
            advertiser_id: 1,
            day_performance: Date.today
          }],
          rows: 1
       })

      #   report_id: :performance_report,
      #   line_item_name: 'Ad Man',
      #   line_item_type_id: :banner,
      #   line_item_budget: 10_000.0,
      #   start_date: Time.now,
      #   bidding: bidding,
      #   active: false
      # )
      expect(response).to eql([{cpm: 12, advertiser_name: 'Foo'}])
    end
  end
end
