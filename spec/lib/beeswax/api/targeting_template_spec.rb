require 'spec_helper'

describe Beeswax::TargetingTemplate do
  describe :create do
    let(:targeting) do
      {
        content_category: {
          exclude: [{
            content_category: 1
          }]
        }
      }
    end

    it "should raise error if :active not provided" do
      expect {
        Beeswax::TargetingTemplate.create(
          active: 'no?'
        )
      }.to raise_error(BeeswaxError, 'Beeswax::TargetingTemplate.create -> :active requred to be true or false')
    end

    it "should return just the payload portion of the response" do
      allow(Beeswax).to receive(:request).
                        with(:post, Beeswax::TargetingTemplate::PATH, hash_including(
                          active: true,
                          strategy_id: 1
                        )).
                        and_return({payload: {id: 1}})

      response = Beeswax::TargetingTemplate.create(
        template_name: 'Ad Man',
        alternative_id: 'Targeting 1',
        strategy_id: :banner,
        targeting: targeting,
        active: true
      )
      expect(response).to eql({id: 1})
    end

  end

end
