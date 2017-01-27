require 'spec_helper'

RSpec.describe Beeswax::Segment do
  describe :create do

    it "should return just the payload portion of the response" do
      allow(Beeswax).to receive(:request).
                         and_return({payload: {id: 1}})

      response = Beeswax::Segment.create(segment_name: 'Ad Man')
      expect(response).to eql({id: 1})
    end
  end
end
