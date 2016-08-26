require 'spec_helper'

describe Beeswax::CreativeLineItem do
  describe :create do
    it "should raise error if :creative_id not present" do
      expect {
        Beeswax::CreativeLineItem.create()
      }.to raise_error(BeeswaxError, 'Beeswax::CreativeLineItem.create -> :creative_id required')
    end

    it "should raise error if :line_item_id not present" do
      expect {
        Beeswax::CreativeLineItem.create(
          creative_id: 1,
          line_item_id: nil
        )
      }.to raise_error(BeeswaxError, 'Beeswax::CreativeLineItem.create -> :line_item_id required')
    end

    it "should raise error if :active not present" do
      expect {
        Beeswax::CreativeLineItem.create(
          creative_id: 1,
          line_item_id: 1,
          active: nil
        )
      }.to raise_error(BeeswaxError, 'Beeswax::CreativeLineItem.create -> :active required to be true or false')
    end

    it "should return just the payload portion of the response" do
      allow(Beeswax).to receive(:request).
                        with(:post, Beeswax::CreativeLineItem::PATH, hash_including(
                          creative_id: 1,
                          line_item_id: 1,
                          active: true
                        )).
                        and_return({payload: {id: 1}})

      response = Beeswax::CreativeLineItem.create(
        creative_id: 1,
        line_item_id: 1,
        active: true
      )
      expect(response).to eql({id: 1})
    end

  end
end
