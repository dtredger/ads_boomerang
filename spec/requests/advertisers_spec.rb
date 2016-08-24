require 'rails_helper'

RSpec.describe "Advertisers", type: :request do
  describe "GET /advertiser" do
    context "unauthenticated" do
      it "redirects" do
        get "/advertiser"
        expect(response).to redirect_to(root_path)
      end
    end


    context "authenticated" do
      sign_in FactoryGirl.create(:advertiser)

      it "shows advertiser page" do
        get "/advertiser"
        expect(response).to have_http_status(200)
      end

	    sign_out(Advertiser.first)
    end

  end
end
