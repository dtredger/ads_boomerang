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

	describe "#website_tag" do
		it "returns script with website ID" do
			website
			expect(website.website_tag).to match(/px.js\?id\=#{website.id}\&s\=/)
		end

	end

	describe "#tag_placed?" do
		it "fails by default" do
			website
			expect(website.tag_placed?).to eq(false)
		end

		describe "succeeds when query-string visited" do
			it "works without trailing slash" do
				website.pages.push(website.homepage+"?adsboomerangtest=verify")
				website.save
				website.reload
				expect(website.tag_placed?).to eq(true)
			end

			it "works with trailing slash" do
				website = create(:website, domain_name: 'http://www.test.com/')
				website.pages.push(website.homepage+"?adsboomerangtest=verify")
				website.save
				website.reload
				expect(website.tag_placed?).to eq(true)
			end
		end
	end
end
