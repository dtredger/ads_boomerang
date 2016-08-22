require "rails_helper"

RSpec.describe CreativesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/creatives").to route_to("creatives#index")
    end

    it "routes to #new" do
      expect(:get => "/creatives/new").to route_to("creatives#new")
    end

    it "routes to #show" do
      expect(:get => "/creatives/1").to route_to("creatives#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/creatives/1/edit").to route_to("creatives#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/creatives").to route_to("creatives#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/creatives/1").to route_to("creatives#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/creatives/1").to route_to("creatives#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/creatives/1").to route_to("creatives#destroy", :id => "1")
    end

  end
end
