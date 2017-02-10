require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do

	describe "GET #index" do
		context "not authenticated" do
			it "redirects to new session path" do
				get :index
				expect(response).to redirect_to(new_advertiser_session_path)
			end
		end

		context "authenticated" do
			login_advertiser
			before { 3.times { create(:campaign, advertiser: advertiser) } }

			before(:each) { get :index }

			it "renders :index" do
				expect(response).to render_template(:index)
			end
			it "shows advertiser's campaigns as @campaign" do
				expect(assigns[:campaigns].length).to eq(3)
			end
			it "does not show other Advertisers' campaigns" do
				3.times { create(:campaign) }
				get :index
				expect(assigns[:campaigns].length).to eq(3)
			end
		end
	end

	describe "GET #show" do
		let(:campaign) { create(:campaign, advertiser: advertiser) }

		context "not authenticated" do
			let(:advertiser) { create(:advertiser) }

			it "redirects to new session path" do
				get :show, params: { id: campaign.id }
				expect(response).to redirect_to(new_advertiser_session_path)
			end
		end

		context "authenticated" do
			login_advertiser

			context "not authorized" do
				let(:campaign_2) { create(:campaign) }

				it "redirects to campaigns index" do
					get :show, params: { id: campaign_2.id }
					expect(response).to redirect_to(campaigns_url)
				end
			end

			context "authorized" do
				before(:each) { get :show, params: { id: campaign.id } }

				it "renders :show" do
					expect(response).to render_template :show
				end
				it "sets campaign as @campaign" do
					expect(assigns[:campaign]).to eq(campaign)
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

			it "assigns new Campaign" do
				get :new
				expect(assigns(:campaign)).to be_a_new(Campaign)
			end
		end
	end

	describe "POST #create" do
		context "not authenticated" do
			subject { post :create, params: { campaign: attributes_for(:campaign) } }

			it "redirects to new session path" do
				subject
				expect(response).to redirect_to(new_advertiser_session_path)
			end
			it "does not create Campaign" do
				expect { subject }.not_to change(Campaign, :count)
			end
		end

		context "authenticated" do
			login_advertiser

			context "unauthorized" do
				let!(:different_advertiser) { create(:advertiser) }
				let!(:website) { create(:website, advertiser: different_advertiser) }

				subject { post :create, params: { campaign: attributes_for(:campaign, advertiser: different_advertiser,
				                                                           website_id: website.id) } }

				it "creates a new Campaign" do
					expect { subject }.to change(Campaign, :count).by(1)
				end
				it "does not allow setting advertiser" do
					subject
					expect(Campaign.first.advertiser).to eq(advertiser)
				end
			end

			context "authorized" do
				context "with invalid params" do
					it "assigns a newly created but unsaved campaign as @campaign" do
						post :create, params: { campaign: attributes_for(:campaign, name: "") }
						expect(assigns(:campaign)).to be_a_new(Campaign)
					end

					it "re-renders the 'new' template" do
						post :create, params: { campaign: attributes_for(:campaign, name: "") }
						expect(response).to render_template("new")
					end
				end

				context "with valid params" do
					let(:website) { create(:website, advertiser: advertiser) }

					it "creates a new Campaign" do
						expect {
							post :create, params: { campaign: attributes_for(:campaign, advertiser: advertiser, website_id: website.id) }
						}.to change(Campaign, :count).by(1)
					end
				end
			end
		end
	end

	describe "GET #edit" do
		let(:campaign) { create(:campaign, advertiser: advertiser) }

		context "not authenticated" do
			let(:campaign) { create(:campaign) }

			it "redirects to new session path" do
				get :edit, params: { id: campaign.id }
				expect(response).to redirect_to(new_advertiser_session_path)
			end
		end

		context "authenticated" do
			login_advertiser

			context "not authorized" do
				let(:other_campaign) { create(:campaign) }

				it "redirects_to campaigns index" do
					get :edit, params: { id: other_campaign.id }
					expect(response).to redirect_to(campaigns_url)
				end
			end

			context "authorized" do
				it "assigns requested campaign as @campaign" do
					get :edit, params: { id: campaign.to_param }
					expect(assigns(:campaign)).to eq(campaign)
				end
			end
		end
	end

	describe "PUT #update" do
		context "not authenticated" do
			let!(:campaign) { create(:campaign) }

			it "redirects to new session path" do
				put :update, params: { id: campaign.to_param, campaign: attributes_for(:campaign) }
				expect(response).to redirect_to(new_advertiser_session_path)
			end
		end

		context "authenticated" do
			login_advertiser

			context "not authorized" do
				let(:other_account_campaign) { create(:campaign) }
				before { put :update, params: { id: other_account_campaign.id, campaign: attributes_for(:campaign, name: "") } }

				it "does not update the campaign" do
					other_account_campaign.reload
					expect(other_account_campaign.name).not_to eq("new name")
				end
				it "redirects to campaigns index" do
					expect(response).to redirect_to(campaigns_url)
				end
			end

			context "authorized" do
				let(:campaign) { create(:campaign, advertiser: advertiser) }

				context "with invalid params" do
					before { put :update, params: { id: campaign.id, campaign: attributes_for(:campaign, name: "") } }

					it "does not updates the campaign" do
						campaign.reload
						expect(campaign.name).not_to eq("new name")
					end
					it "assigns the campaign as @campaign" do
						expect(assigns(:campaign)).to eq(campaign)
					end
				end

				context "with valid params" do
					before { put :update, params: { id: campaign.id, campaign: attributes_for(:campaign, name: "new name") } }

					it "updates the requested campaign" do
						campaign.reload
						expect(campaign.name).to eq("new name")
					end
				end
			end
		end
	end

	describe "DELETE #destroy" do
		context "not authenticated" do
			let!(:campaign) { create(:campaign) }

			it "redirects to new session path" do
				get :edit, params: { id: campaign.id }
				expect(response).to redirect_to(new_advertiser_session_path)
			end
		end

		context "authenticated" do
			login_advertiser
			let!(:campaign) { create(:campaign, advertiser: advertiser) }

			context "not authorized" do
				let!(:other_account_campaign) { create(:campaign) }

				it "does not destroy campaign" do
					expect {
						delete :destroy, params: { id: other_account_campaign.id }
					}.not_to change(Campaign, :count)
				end
				it "redirects to campaigns index" do
					delete :destroy, params: { id: other_account_campaign.id }
					expect(response).to redirect_to(campaigns_url)
				end
			end

			context "authorized" do
				it "destroys the requested campaign" do
					expect {
						delete :destroy, params: { id: campaign.id }
					}.to change(Campaign, :count).by(-1)
				end

				it "redirects to the campaigns list" do
					delete :destroy, params: { id: campaign.id }
					expect(response).to redirect_to(campaigns_url)
				end
			end
		end
	end

end

