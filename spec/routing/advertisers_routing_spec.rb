require "rails_helper"

RSpec.describe AdvertisersController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/advertisers/new").to route_to("advertisers#new")
    end

    it "routes to #show" do
      expect(:get => "/advertisers/1").to route_to("advertisers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/advertisers/1/edit").to route_to("advertisers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/advertisers").to route_to("advertisers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/advertisers/1").to route_to("advertisers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/advertisers/1").to route_to("advertisers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/advertisers/1").to route_to("advertisers#destroy", :id => "1")
    end

  end
end
