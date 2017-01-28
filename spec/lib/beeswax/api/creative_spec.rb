require 'spec_helper'

RSpec.describe Beeswax::Creative do
  describe :create do

    it "should raise error if :advertiser_id is not present" do
      expect {
        Beeswax::Creative.create()
      }.to raise_error(BeeswaxError, 'Beeswax::Creative.create -> :advertiser_id required')
    end

    it "should raise error if :creative_name is not present" do
      expect {
        Beeswax::Creative.create(advertiser_id: 1, creative_name: nil)
      }.to raise_error(BeeswaxError, 'Beeswax::Creative.create -> :creative_name required')
    end

    it "should raise error if :creative_template_id not present" do
      expect {
        Beeswax::Creative.create(
          advertiser_id: 1,
          creative_name: 'Ad No. 1',
          creative_template_id: nil
        )
      }.to raise_error(BeeswaxError, 'Beeswax::Creative.create -> :creative_template_id [Integer] required')
    end

    it "should raise error if :active not present" do
      expect {
        Beeswax::Creative.create(
          advertiser_id: 1,
          creative_name: 'Ad No. 1',
          creative_template_id: 1,
          active: nil
        )
      }.to raise_error(BeeswaxError, 'Beeswax::Creative.create -> :active required to be true or false')
    end

    it "should return just the payload portion of the response" do
      allow(Beeswax).to receive(:request).
                        with(:post, Beeswax::Creative::PATH, hash_including(
                          :advertiser_id=>1,
                          creative_name: 'AD No. 1',
                          creative_type: 0,
                          width: 728,
                          height: 90,
                          sizeless: false,
                          secure: false,
                          active: true
                        )).
                        and_return({payload: {id: 1}})

      response = Beeswax::Creative.create(
        advertiser_id: 1,
        creative_name: 'AD No. 1',
        width: 728,
        height: 90,
        creative_template_id: 1,
        creative_attributes: {
          advertiser: {
            advertiser_domain: ['https://my-domain.com']
          }
        },
        active: true
      )
      expect(response).to eql({id: 1})
    end
  end

  describe :update do
    it "should return just the payload portion of the response" do
        allow(Beeswax).to receive(:request).
                          with(:put, Beeswax::Creative::PATH, hash_including(
                            creative_id: 1, active: true
                          )).
                          and_return({payload: {id: 1, success: true, message: "creative updated with ID 1"}})

      response = Beeswax::Creative.update(
        creative_id: 1,
        active: true
      )
      expect(response).to eql(
        {id: 1, success: true, message: "creative updated with ID 1"}
      )
    end
  end

  describe :delete do
    it "should return just the payload portion of the response" do
        allow(Beeswax).to receive(:request).
                          with(:delete, Beeswax::Creative::PATH, hash_including(
                            creative_id: 1
                          )).
                          and_return({payload: {id: 1, success: true, message: "creative updated with ID 1"}})

      response = Beeswax::Creative.delete(creative_id: 1)
      expect(response).to eql(
        {id: 1, success: true, message: "creative updated with ID 1"}
      )
    end
  end
end
