require 'rails_helper'

RSpec.describe WebsitesController, type: :controller do

  describe "POST #create" do
	  let(:valid_attributes) { {name: 'test', domain_name: 'http://test.com', notes: 'a test', hosting_provider: '1'} }
	  let(:invalid_attributes) { {name: "", domain_name: 'invalid', notes: 'invalid', hosting_provider: 'str'} }

	  context "not authenticated" do
		  it "does not create Website" do
			  expect {
				  post :create, params: {website: valid_attributes}
			  }.not_to change(Website, :count)
		  end

		  it "redirects to the created website" do
			  post :create, params: {website: valid_attributes}
			  expect(response).to redirect_to(new_advertiser_session_path)
		  end
	  end

	  context "authorized" do
		  login_advertiser

			context "with valid params" do
				it "creates a new Website" do
				  expect {
					  post :create, params: {website: valid_attributes}
				  }.to change(Website, :count).by(1)
				end

				it "assigns a newly created website as @website" do
				  post :create, params: {website: valid_attributes}
				  expect(assigns(:website)).to be_a(Website)
				  expect(assigns(:website)).to be_persisted
				end

				it "redirects to the created website" do
				  post :create, params: {website: valid_attributes}
				  expect(response).to redirect_to(Website.last)
				end
			end

		  context "with invalid params" do
			  it "assigns a newly created but unsaved website as @website" do
				  post :create, params: {website: invalid_attributes}
				  expect(assigns(:website)).to be_a_new(Website)
			  end

			  it "re-renders the 'new' template" do
				  post :create, params: {website: invalid_attributes}
				  expect(response).to render_template("new")
			  end
		  end
	  end

  end

end
