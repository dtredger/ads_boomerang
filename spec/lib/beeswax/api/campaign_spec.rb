require 'spec_helper'

RSpec.describe Beeswax::Campaign do
  describe :create do
    it "should raise error if :advertiser_id is not present" do
      expect {
        Beeswax::Campaign.create(advertiser_id: nil)
      }.to raise_error(BeeswaxError, 'Beeswax::Campaign.create -> :advertiser_id required')
    end

    it "should raise error if :campaign_name is not present" do
      expect {
        Beeswax::Campaign.create(advertiser_id: 1)
      }.to raise_error(BeeswaxError, 'Beeswax::Campaign.create -> :campaign_name required')
    end

    it "should raise error if :campaign_budget is not present" do
      expect {
        Beeswax::Campaign.create(advertiser_id: 1, campaign_name: 'Ad Man')
      }.to raise_error(BeeswaxError, 'Beeswax::Campaign.create -> :campaign_budget required to be a Float')
    end

    it "should raise error if :start_date not present" do
      expect {
        Beeswax::Campaign.create(
          advertiser_id: 1,
          campaign_name: 'Ad Man',
          campaign_budget: 10_000.00,
          start_date: nil
        )
      }.to raise_error("Beeswax::Campaign.create -> :start_date required")
    end

    it "should raise error if :active is not present" do
      expect {
        Beeswax::Campaign.create(
          advertiser_id: 1,
          campaign_name: 'Ad Man',
          campaign_budget: 10_000.00,
          start_date: Time.now
        )
      }.to raise_error(BeeswaxError, 'Beeswax::Campaign.create -> :active must be true or false')
    end

    it "should raiase error if revenue_type set but not valid option" do
      expect {
        Beeswax::Campaign.create(
          advertiser_id: 1,
          campaign_name: 'Ad Man',
          campaign_budget: 10_000.00,
          start_date: Time.now,
          active: true,
          revenue_type: 'CPWHAT?'
        )
      }.to raise_error("Beeswax::Campaign.create -> :revenue_type must be 'CPM' or 'CPC' if specified")
    end

    it "should return just the payload portion of the response" do
      allow(Beeswax).to receive(:request).
                        with(:post, Beeswax::Campaign::PATH, hash_including(advertiser_id: 1, campaign_name: "Ad Man", campaign_budget: 10000.0, active: true, budget_type: 1, pacing: 0)).
                        and_return({payload: {id: 1}})

      response = Beeswax::Campaign.create(
        advertiser_id: 1,
        campaign_name: 'Ad Man',
        campaign_budget: 10_000.00,
        budget_type: :impressions,
        start_date: Time.now,
        active: true
      )
      expect(response).to eql({id: 1})
    end
  end
end
