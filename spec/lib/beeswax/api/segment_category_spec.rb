require 'spec_helper'

RSpec.describe Beeswax::SegmentCategory do
  describe :create do
    it "should raise error when :segment_category_name is not present" do
      expect {
        Beeswax::SegmentCategory.create()
      }.to raise_error(BeeswaxError, 'Beeswax::SegmentCategory.create -> :segment_category_name required')
    end

    it "should return just the payload portion of the response" do
      allow(Beeswax).to receive(:request).
                        with(:post, Beeswax::SegmentCategory::PATH, hash_including(        segment_category_name: 'Ad Man',
                          alternative_id: '1',
                          parent_category_key: 'stingersbx-999',
                          advertiser_id: 1
                        )).
                        and_return({payload: {id: 1}})

      response = Beeswax::SegmentCategory.create(
        segment_category_name: 'Ad Man',
        alternative_id: '1',
        parent_category_key: 'stingersbx-999',
        advertiser_id: 1
      )
      expect(response).to eql({id: 1})
    end

  end
end
