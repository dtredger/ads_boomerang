require 'spec_helper'

describe Beeswax::CreativeTemplate do
  describe :create do
    it "should raise error if :creative_template_name not present" do
      expect {
        Beeswax::CreativeTemplate.create()
      }.to raise_error(BeeswaxError, 'Beeswax::CreativeTemplate.create -> :creative_template_name [String] required')
    end

    it "should raise error if :rendering_key not present" do
      expect {
        Beeswax::CreativeTemplate.create(
          creative_template_name: 'Ad Image'
        )
      }.to raise_error(BeeswaxError, 'Beeswax::CreativeTemplate.create -> :rendering_key [String] required')
    end

    it "should raise error if :creative_template_content not present" do
      expect {
        Beeswax::CreativeTemplate.create(
          creative_template_name: 'Ad Image',
          rendering_key: 'IMAGE'
        )
      }.to raise_error(BeeswaxError, 'Beeswax::CreativeTemplate.create -> :creative_template_content [String] required')
    end

    it "should raise error if :active not present" do
      expect {
        Beeswax::CreativeTemplate.create(
          creative_template_name: 'Ad Image',
          rendering_key: 'IMAGE',
          creative_template_content: "<a href='{{CLICK_URL}} />",
          active: nil
        )
      }.to raise_error(BeeswaxError, 'Beeswax::CreativeTemplate.create -> :active required to be true or false')
    end

    it "should return just the payload portion of the response" do
      allow(Beeswax).to receive(:request).
                        with(:post, Beeswax::CreativeTemplate::PATH, hash_including(
                          global: false,
                          creative_template_name: 'Ad Image',
                          rendering_key: 'IMAGE',
                          creative_template_content: "<a href='{{CLICK_URL}} />",
                          active: true
                        )).
                        and_return({payload: {id: 1}})

      response = Beeswax::CreativeTemplate.create(
        creative_template_name: 'Ad Image',
        rendering_key: 'IMAGE',
        creative_template_content: "<a href='{{CLICK_URL}} />",
        active: true
      )
      expect(response).to eql({id: 1})
    end

  end
end
