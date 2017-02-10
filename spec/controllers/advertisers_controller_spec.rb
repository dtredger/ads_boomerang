require 'rails_helper'

RSpec.describe AdvertisersController, type: :controller do

  describe "GET #show" do
	  context "not authenticated" do
		  it "redirects to login" do
			  get :show
			  expect(response).to redirect_to(new_advertiser_session_path)
		  end
	  end

	  context "authenticated" do
		  login_advertiser

		  it "responds with 200" do
			  get :show
			  expect(response.status).to eq(200)
		  end
	  end

  end

end
