require 'spec_helper'

RSpec.describe Beeswax::LineItem do
  describe :create do
    let(:bidding) do
      {"bidding_strategy": "cpm", "values": {"cpm_bid":1.12} }
    end

    it "should raise error if :advertiser_id is not present" do
      expect {
        Beeswax::LineItem.create(advertiser_id: nil)
      }.to raise_error(BeeswaxError, 'Beeswax::LineItem.create -> :advertiser_id required')
    end

    it "should raise error if :line_item_name is not present" do
      expect {
        Beeswax::LineItem.create(advertiser_id: 1, line_item_name: nil)
      }.to raise_error(BeeswaxError, 'Beeswax::LineItem.create -> :line_item_name required')
    end

    it "should raise error if :line_item_budget is not present" do
      expect {
        Beeswax::LineItem.create(advertiser_id: 1, line_item_name: 'Ad Man')
      }.to raise_error(BeeswaxError, 'Beeswax::LineItem.create -> :line_item_budget required to be a Float')
    end

    it "should raise error if :active is true on POST" do
      expect {
        Beeswax::LineItem.create(
          advertiser_id: 1,
          line_item_name: 'Ad Man',
          line_item_budget: 10_000.0,
          start_date: Time.now
        )
      }.to raise_error(BeeswaxError, 'Beeswax::LineItem.create -> :active can not be true on create. No Creative paired yet.')
    end

    it "should raise error if :bidding not present" do
      expect {
        Beeswax::LineItem.create(
          advertiser_id: 1,
          line_item_name: 'Ad Man',
          active: false,
          line_item_budget: 10_000.0,
          start_date: Time.now,
          bidding: nil
        )
      }.to raise_error("Beeswax::LineItem.create -> :bidding object required ie. {'bidding_strategy': 'cpm', 'values': {'cpm_bid': 1.12} }")
    end

    it "should raise error if :start_date not present" do
      expect {
        Beeswax::LineItem.create(
          advertiser_id: 1,
          line_item_name: 'Ad Man',
          active: false,
          line_item_budget: 10_000.0,
          bidding: bidding
        )
      }.to raise_error("Beeswax::LineItem.create -> :start_date required")
    end

    it "should raise error if :revenue_type set but not valid option" do
      expect {
        Beeswax::LineItem.create(
        advertiser_id: 1,
        line_item_name: 'Ad Man',
        active: false,
        line_item_budget: 10_000.0,
        bidding: bidding,
        start_date: Time.now,
        revenue_type: 'CPWHAT?'
        )
      }.to raise_error("Beeswax::LineItem.create -> :revenue_type must be 'CPM' or 'CPC' if specified")
    end


    it "should return just the payload portion of the response" do
      allow(Beeswax).to receive(:request).
                        with(:post, Beeswax::LineItem::PATH, hash_including(
                          :advertiser_id=>1, :line_item_name=>"Ad Man", :line_item_budget=>10000.0, :start_date=>within(5).of(Time.now), :bidding=>{:bidding_strategy=>"cpm", :values=>{:cpm_bid=>1.12}}, :active=>false, :line_item_type_id=>0, :budget_type=>0, :pacing=>0
                        )).
                        and_return({payload: {id: 1}})

      response = Beeswax::LineItem.create(
        advertiser_id: 1,
        line_item_name: 'Ad Man',
        line_item_type_id: :banner,
        line_item_budget: 10_000.0,
        start_date: Time.now,
        bidding: bidding,
        active: false
      )
      expect(response).to eql({id: 1})
    end
  end

  describe :update do
    it "should raise error if :line_item_id is not present" do
      expect {
        Beeswax::LineItem.update()
      }.to raise_error(BeeswaxError, 'Beeswax::LineItem.create -> :line_item_id required')
    end

    it "should return just the payload portion of the response" do
        allow(Beeswax).to receive(:request).
                          with(:put, Beeswax::LineItem::PATH, hash_including(
                            line_item_id: 1, targeting_template_id: 1, active: true
                          )).
                          and_return({payload: {id: 1, success: true, message: "line_item updated with ID 1"}})

      response = Beeswax::LineItem.update(
        line_item_id: 1,
        targeting_template_id: 1,
        active: true
      )
      expect(response).to eql(
        {id: 1, success: true, message: "line_item updated with ID 1"}
      )
    end
  end
end
