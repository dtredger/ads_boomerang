require 'spec_helper'

describe Beeswax::Advertiser do
  describe :create do
    it "should raise an error if :advertiser_name is not provided" do
      expect {
        Beeswax::Advertiser.create()
      }.to raise_error(BeeswaxError, 'Beeswax::Advertiser.create -> :advertiser_name required')
    end

    it "should set :conversion_method_id to 1 for last_click if not provided" do
      expect(Beeswax).to receive(:request).
                         with(:post, Beeswax::Advertiser::PATH, hash_including(conversion_method_id: 1)).
                         and_return({})
      Beeswax::Advertiser.create(advertiser_name: 'Ad Man')
    end

    it "should return just the payload portion of the response" do
      allow(Beeswax).to receive(:request).
                         and_return({payload: {id: 1}})

      response = Beeswax::Advertiser.create(advertiser_name: 'Ad Man')

      expect(response).to eql({id: 1})
    end
  end
end
