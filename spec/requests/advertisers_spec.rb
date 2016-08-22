require 'rails_helper'

RSpec.describe "Advertisers", type: :request do
  describe "GET /advertisers" do
    it "works! (now write some real specs)" do
      get advertisers_path
      expect(response).to have_http_status(200)
    end
  end
end
