# == Schema Information
#
# Table name: websites
#
#  id               :integer          not null, primary key
#  name             :string
#  domain_name      :string
#  provider         :integer
#  pages            :json
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  hosting_provider :integer
#  notes            :string
#  advertiser_id    :integer
#

require 'rails_helper'

RSpec.describe Website, type: :model do
	let!(:website) { create(:website) }

	context "callbacks" do
		describe "#write_page_categories" do
			let(:advertiser) { create(:advertiser) }

			it "presets json page categories" do
				website = advertiser.websites.create(name: 'test', domain_name: 'http://test.com')
				expect(website.pages).to match({"all"=>[], "add"=>[], "exclude"=>[]})
			end
		end
	end

	describe "#website_tag" do
		it "returns script with website ID" do
			website
			expect(website.website_tag).to match(/px.js\?id\=#{website.id}\&s\=/)
		end

	end

	describe "#tag_placed?" do
		it "fails by default" do
			expect(website.tag_placed?).to eq(false)
		end

		describe "succeeds when query-string visited" do
			it "works without trailing slash" do
				website.pages = { all: website.homepage+"?adsboomerangtest=verify" }
				website.save
				website.reload
				expect(website.tag_placed?).to eq(true)
			end

			it "works with trailing slash" do
				website.pages = { all: website.homepage+"/?adsboomerangtest=verify" }
				website.save
				website.reload
				expect(website.tag_placed?).to eq(true)
			end
		end
	end

	describe "#get_segment" do
		context "unknown page" do
			it "adds to ALL pages" do
				website.get_segment("http://test.com/unknown2")
				expect(website.pages["all"]).to eq(["http://test.com/unknown2"])
			end

			it "does not target with tag" do
				expect(website.get_segment("http://test.com/unknown")).to eq(nil)
			end
		end

		context "known ADD page" do
			before { website.update(pages: { all: ["http://test.com/known"], add: ["http://test.com/known"] }) }

			it "does not add to pages" do
				expect{
					website.get_segment("http://test.com/known")
				}.not_to change(website, :pages)
			end

			context "no add_segment" do
				it "returns nil" do
					expect(website.get_segment("http://test.com/known")).to eq(nil)
				end
			end

			context "add_segment exists" do
				before { create(:segment, campaign: website.campaign, audience_type: "add") }

				it "returns ADD tag retarget_src" do
					expect(website.get_segment("http://test.com/known")).to eq(website.campaign.include_segment.retarget_src)
				end
			end
		end

		context "known EXCLUDE page" do
			before { website.update(pages: {all: ["http://test.com/exclude"], exclude:["http://test.com/exclude"]}) }

			it "does not add to pages" do
				expect{
					website.get_segment("http://test.com/exclude")
				}.not_to change(website, :pages)
			end

			context "no exclude_segment" do
				it "returns nil" do
					expect(website.get_segment("http://test.com/exclude")).to eq(nil)
				end
			end

			context "exclude_segment exists" do
				before { create(:segment, campaign: website.campaign, audience_type: "exclude") }

				it "returns EXCLUDE tag retarget_src" do
					expect(website.get_segment("http://test.com/exclude")).to eq(website.campaign.exclude_segment.retarget_src)
				end
			end
		end

		context "pages as array" do
			describe "empty array" do
				before { website.update(pages: []) }

				it "does not raise error" do
					expect{
						website.get_segment("http://test.com/include")
					}.not_to raise_error
				end

				it "returns nil" do
					expect(website.get_segment("http://test.com/exclude")).to eq(nil)
				end
			end

			describe "array with URLs" do
				before { website.update(pages: ["http://test.com/exclude", "http://test.com/include"]) }

				it "does not raise error" do
					expect{
						website.get_segment("http://test.com/include")
					}.not_to raise_error
				end

				it "returns nil" do
					expect(website.get_segment("http://test.com/exclude")).to eq(nil)
				end
			end
		end
	end

	describe "#ready_to_launch?" do
		let(:campaign) { create(:campaign, website: website, advertiser: website.advertiser) }

		subject do
			website.pages["all"].push(website.homepage + "/?adsboomerangtest=verify")
			website.save
			campaign.update(active:true)
			create(:creative, campaign: campaign)
		end

		context "no tag visits" do
			it "returns false" do
				subject
				website.pages["all"] = []
				website.save
				expect(website.ready_to_launch?).to eq(false)
			end
		end

		context "no creatives" do
			it "returns false" do
				subject
				Creative.destroy_all
				expect(website.ready_to_launch?).to eq(false)
			end
		end

		context "no campaign active" do
			it "returns false" do
				subject
				website.campaign.update(active: false)
				expect(website.ready_to_launch?).to eq(false)
			end
		end

		context "three steps complete" do
			it "returns true" do
				subject
				expect(website.ready_to_launch?).to eq(true)
			end
		end
	end
end
