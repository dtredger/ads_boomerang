require 'spec_helper'

describe Beeswax::CreativeAsset do
  describe :create do

    it "should raise error if :advertiser_id not present" do
      expect {
        Beeswax::CreativeAsset.create()
      }.to raise_error(BeeswaxError, 'Beeswax::CreativeAsset.create -> :advertiser_id required')
    end

    it "should raise error if :creative_asset_name not present" do
      expect {
        Beeswax::CreativeAsset.create(
          advertiser_id: 1,
          creative_asset_name: nil
        )
      }.to raise_error(BeeswaxError, 'Beeswax::CreativeAsset.create -> :creative_asset_name [String] required')
    end

    it "should raise error if :size_in_bytes not present" do
      expect {
        Beeswax::CreativeAsset.create(
          advertiser_id: 1,
          creative_asset_name: 'Ad No 1',
          size_in_bytes: nil
        )
      }.to raise_error(BeeswaxError, 'Beeswax::CreativeAsset.create -> :size_in_bytes [Integer] required')
    end

    it "should raise error if :active not present" do
      expect {
        Beeswax::CreativeAsset.create(
          advertiser_id: 1,
          creative_asset_name: 'Ad No 1',
          size_in_bytes: 300_000,
          active: nil
        )
      }.to raise_error(BeeswaxError, 'Beeswax::CreativeAsset.create -> :active required to be true or false')
    end

    it "should return just the payload portion of the response" do
      allow(Beeswax).to receive(:request).
                        with(:post, Beeswax::CreativeAsset::PATH, hash_including(
                          advertiser_id: 1,
                          creative_asset_name: 'Ad No 1',
                          size_in_bytes: 300_000,
                          active: true
                        )).
                        and_return({payload: {id: 1}})

      response = Beeswax::CreativeAsset.create(
        advertiser_id: 1,
        creative_asset_name: 'Ad No 1',
        size_in_bytes: 300_000,
        active: true
      )
      expect(response).to eql({id: 1})
    end

  end

  describe :upload do
    let(:data) { 'ABCDEFG' }
    let(:creative_asset_id) { 1 }
    let(:expected_url) { "#{Beeswax::CreativeAsset::PATH}/upload/#{creative_asset_id}" }
    it "should return just the payload portion of the response" do
      allow(Beeswax).to receive(:multipart_request).
                        with(:post, expected_url, {file: data}).
                        and_return({payload: {id: 1}})

      response = Beeswax::CreativeAsset.upload(
        creative_asset_id: 1,
        creative_content: data
      )
      expect(response).to eql({id: 1})
    end

  end
end
