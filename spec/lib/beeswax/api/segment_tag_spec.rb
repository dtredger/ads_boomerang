require 'spec_helper'

RSpec.describe Beeswax::SegmentTag do
  describe :create do
    let(:tag) {
      "<!--BEGIN BEESWAX SEGMENT TAG, DO NOT REMOVE -->\n<img src=\"http://segment.prod.bidr.io/associate-segment?buzz_key=stingersbx&segment_key=stingertest-1&value=[VALUE]\" height=\"0\" width=\"0\">\n<!--END BEESWAX SEGMENT TAG, DO NOT REMOVE -->"
    }

    it "should return just the payload portion of the response" do
      allow(Beeswax).to receive(:request).
                        with(:get, Beeswax::SegmentTag::PATH, hash_including(tag_type: 'js')).
                        and_return({payload: {tag: tag}})

      response = Beeswax::SegmentTag.get(segment_name: 'Ad Man')
      expect(response).to eql({tag: tag})
    end
  end
end
