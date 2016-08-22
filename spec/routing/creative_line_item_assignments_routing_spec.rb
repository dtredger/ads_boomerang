require "rails_helper"

RSpec.describe CreativeLineItemAssignmentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/creative_line_item_assignments").to route_to("creative_line_item_assignments#index")
    end

    it "routes to #new" do
      expect(:get => "/creative_line_item_assignments/new").to route_to("creative_line_item_assignments#new")
    end

    it "routes to #show" do
      expect(:get => "/creative_line_item_assignments/1").to route_to("creative_line_item_assignments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/creative_line_item_assignments/1/edit").to route_to("creative_line_item_assignments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/creative_line_item_assignments").to route_to("creative_line_item_assignments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/creative_line_item_assignments/1").to route_to("creative_line_item_assignments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/creative_line_item_assignments/1").to route_to("creative_line_item_assignments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/creative_line_item_assignments/1").to route_to("creative_line_item_assignments#destroy", :id => "1")
    end

  end
end
