require 'rails_helper'

RSpec.describe CreativesController, type: :controller do

  describe "GET #index" do
	  context "not authenticated" do
		  it "redirects to new session path" do
			  get :index
			  expect(response).to redirect_to(new_advertiser_session_path)
		  end
	  end

	  context "authenticated" do
		  login_advertiser
		  before { 3.times { create(:creative, advertiser: advertiser) } }

		  before(:each) { get :index }

		  it "renders :index" do
			  expect(response).to render_template :index
		  end
		  it "shows advertiser's creatives as @creative" do
			  expect(assigns[:creatives].length).to eq(3)
		  end
		  it "does not show other Advertisers' creatives" do
			  3.times { create(:creative) }
			  get :index
			  expect(assigns[:creatives].length).to eq(3)
		  end
	  end
  end

  describe "GET #show" do
	  let(:creative) { create(:creative, advertiser: advertiser) }

	  context "not authenticated" do
		  let(:advertiser) { create(:advertiser) }

		  it "redirects to new session path" do
			  get :show, params: {id: creative.id}
			  expect(response).to redirect_to(new_advertiser_session_path)
		  end
	  end

	  context "authenticated" do
		  login_advertiser

		  context "not authorized" do
			  let(:creative_2) { create(:creative) }

			  it "redirects to creatives index" do
				  get :show, params: { id: creative_2.id }
				  expect(response).to redirect_to(creatives_url)
			  end
		  end

		  context "authorized" do
			  before(:each) { get :show, params: {id: creative.id} }

			  it "renders :show" do
				  expect(response).to render_template :show
			  end
			  it "sets creative as @creative" do
				  expect(assigns[:creative]).to eq(creative)
			  end
		  end
	  end
  end

  describe "GET #new" do
	  context "not authenticated" do
		  it "redirects to new session path" do
			  get :new
			  expect(response).to redirect_to(new_advertiser_session_path)
		  end
	  end

	  context "authenticated" do
		  login_advertiser

		  it "assigns new Creative" do
				get :new
				expect(assigns(:creative)).to be_a_new(Creative)
		  end
	  end
  end

  describe "POST #create" do
	  context "not authenticated" do
		  subject { post :create, params: { creative: attributes_for(:creative) } }

		  it "redirects to new session path" do
			  subject
			  expect(response).to redirect_to(new_advertiser_session_path)
		  end
		  it "does not create Creative" do
			  expect { subject }.not_to change(Creative, :count)
		  end
	  end

	  context "authenticated" do
		  login_advertiser

		  context "unauthorized" do
			  let(:different_advertiser) { create(:advertiser) }
			  subject { post :create, params: { creative: attributes_for(:creative, advertiser: different_advertiser) } }

			  it "creates a new Creative" do
				  expect { subject }.to change(Creative, :count).by(1)
			  end
			  it "does not allow setting advertiser" do
				  subject
				  expect(Creative.last.advertiser).to eq(assigns[:current_advertiser])
			  end
		  end

		  context "authorized" do
			  context "with valid params" do
				  subject { post :create, params: { creative: attributes_for(:creative) } }

				  it "creates a new Creative" do
					  expect { subject }.to change(Creative, :count).by(1)
				  end

				  it "assigns a newly created creative as @creative" do
					  subject
					  expect(assigns(:creative)).to be_persisted
				  end

				  it "redirects to the creative" do
					  subject
					  expect(response).to redirect_to(Creative.last)
				  end
			  end

			  context "with invalid params" do
				  it "assigns a newly created but unsaved creative as @creative" do
					  post :create, params: { creative: attributes_for(:creative, name: "") }
					  expect(assigns(:creative)).to be_a_new(Creative)
				  end

				  it "re-renders the 'new' template" do
					  post :create, params: { creative: attributes_for(:creative, name: "") }
					  expect(response).to render_template("new")
				  end
			  end
		  end
	  end
  end

  describe "GET #edit" do
	  let(:creative) { create(:creative, advertiser: advertiser) }

	  context "not authenticated" do
		  let(:creative) { create(:creative) }

		  it "redirects to new session path" do
			  get :edit, params: { id: creative.id }
			  expect(response).to redirect_to(new_advertiser_session_path)
		  end
	  end

	  context "authenticated" do
		  login_advertiser

		  context "not authorized" do
			  let(:other_creative) { create(:creative) }

			  it "redirects_to creatives index" do
				  get :edit, params: { id: other_creative.id }
				  expect(response).to redirect_to(creatives_url)
			  end
		  end

		  context "authorized" do
			  it "assigns requested creative as @creative" do
				  get :edit, params: { id: creative.to_param }
			    expect(assigns(:creative)).to eq(creative)
			  end
		  end
	  end
  end

  describe "PUT #update" do
	  context "not authenticated" do
		  let!(:creative) { create(:creative) }

		  it "redirects to new session path" do
			  put :update, params: { id: creative.to_param, creative: attributes_for(:creative) }
			  expect(response).to redirect_to(new_advertiser_session_path)
		  end
	  end

	  context "authenticated" do
		  login_advertiser

		  context "not authorized" do
			  let(:other_account_creative) { create(:creative) }
			  before { put :update, params: { id: other_account_creative.id, creative: attributes_for(:creative, name: "") } }

			  it "does not update the creative" do
				  other_account_creative.reload
				  expect(other_account_creative.name).not_to eq("new name")
			  end
			  it "redirects to creatives index" do
				  expect(response).to redirect_to(creatives_url)
			  end
		  end

		  context "authorized" do
			  let(:creative) { create(:creative, advertiser: advertiser) }

			  context "with invalid params" do
				  before { put :update, params: { id: creative.id, creative: attributes_for(:creative, name: "") } }

				  it "does not updates the creative" do
					  creative.reload
					  expect(creative.name).not_to eq("new name")
				  end
				  it "assigns the creative as @creative" do
					  expect(assigns(:creative)).to eq(creative)
				  end
				  it "re-renders the 'edit' template" do
					  expect(response).to render_template(:edit)
				  end
			  end

			  context "with valid params" do
				  before { put :update, params: { id: creative.id, creative: attributes_for(:creative, name: "new name") } }

				  it "updates the requested creative" do
					  creative.reload
					  expect(creative.name).to eq("new name")
				  end
				  it "redirects to the creative" do
					  expect(response).to redirect_to(creative)
				  end
			  end
		  end
	  end
  end

  describe "DELETE #destroy" do
	  context "not authenticated" do
		  let!(:creative) { create(:creative) }

		  it "redirects to new session path" do
			  get :edit, params: { id: creative.id }
			  expect(response).to redirect_to(new_advertiser_session_path)
		  end
	  end

	  context "authenticated" do
		  login_advertiser
		  let!(:creative) { create(:creative, advertiser: advertiser) }

		  context "not authorized" do
			  let!(:other_account_creative) { create(:creative) }

			  it "does not destroy creative" do
				  expect {
					  delete :destroy, params: { id: other_account_creative.id }
				  }.not_to change(Creative, :count)
			  end
			  it "redirects to creatives index" do
				  delete :destroy, params: { id: other_account_creative.id }
				  expect(response).to redirect_to(creatives_url)
			  end
		  end

		  context "authorized" do
			  it "destroys the requested creative" do
				  expect {
					  delete :destroy, params: { id: creative.id }
				  }.to change(Creative, :count).by(-1)
			  end

			  it "redirects to the creatives list" do
				  delete :destroy, params: { id: creative.id }
				  expect(response).to redirect_to(creatives_url)
			  end
		  end
	  end
  end

end
