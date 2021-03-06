require 'rails_helper'

RSpec.describe SegmentsController, type: :controller do

	context "with no ID" do
		subject { get :tag, format: :js }

		it("does not raise error") { expect { subject }.not_to raise_error }

		it "returns 204" do
			subject
			expect(response).to have_http_status(204)
		end
	end

	context "with ID" do
		let(:website) { create(:website) }

		context "with no domain" do
			subject { get :tag, params: {id: website.id }, format: :js }

			it("does not raise error") { expect { subject }.not_to raise_error }

			it "returns 204" do
				subject
				expect(response).to have_http_status(204)
			end
		end

		context "with wrong domain" do
			context "bad URL" do
				subject { get :tag, params: {id: website.id, s: "something wrong"}, format: :js }

				it("does not raise error") { expect { subject }.not_to raise_error }

				it "returns 200" do
					subject
					expect(response).to have_http_status(200)
				end

				it "does not return tag" do
					subject
					expect(assigns(:segment_tag)).to be_nil
				end
			end

			context "valid URL" do
				subject { get :tag, params: {id: website.id, s: "http://ads-boomerang-staging.herokuapp.com"}, format: :js }

				it("does not raise error") { expect { subject }.not_to raise_error }

				it "returns 200" do
					subject
					expect(response).to have_http_status(200)
				end

				it "does not return tag" do
					subject
					expect(assigns(:segment_tag)).to be_nil
				end
			end
		end

		context "with correct domain" do
			subject { get :tag, params: {id: website.id, s: website.domain_name}, format: :js }

			it("does not raise error") { expect { subject }.not_to raise_error }

			context "when no segment exists" do
				it("does not raise error") { expect { subject }.not_to raise_error }

				it "returns 200" do
					subject
					expect(response).to have_http_status(200)
				end

				it "does not return tag" do
					subject
					expect(assigns(:segment_tag)).to be_nil
				end
			end

			context "when segment exists" do
				let(:campaign) { create(:campaign, website: website)}

				before do
					create(:segment, audience_type: "add", campaign: campaign)
					create(:segment, audience_type: "exclude", campaign: campaign)
				end

				context "page not part of ADD pages" do
					it("does not raise error") { expect { subject }.not_to raise_error }

					it "returns 200" do
						subject
						expect(response).to have_http_status(200)
					end

					it "does not return tag" do
						subject
						expect(assigns(:segment_tag)).to be_nil
					end
				end

				context "page is ADD page" do
					before do
						website.pages["add"].push(website.domain_name)
						website.save
					end

					it "returns 200" do
						subject
						expect(response).to have_http_status(200)
					end

					it "returns include_segment tags" do
						subject
						expect(assigns(:segment_tag)).to eq(campaign.include_segment.retarget_src)
					end
				end

				context "page is EXCLUDE page" do
					before do
						website.pages["exclude"].push(website.domain_name)
						website.save
					end

					it "returns 200" do
						subject
						expect(response).to have_http_status(200)
					end

					it "returns exclude_segment tags" do
						subject
						expect(assigns(:segment_tag)).to eq(campaign.exclude_segment.retarget_src)
					end
				end
			end
		end
	end
end
