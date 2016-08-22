require 'rails_helper'

RSpec.describe "CreativeLineItemAssignments", type: :request do
  describe "GET /creative_line_item_assignments" do
    it "works! (now write some real specs)" do
      get creative_line_item_assignments_path
      expect(response).to have_http_status(200)
    end
  end
end
