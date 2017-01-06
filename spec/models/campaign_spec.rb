# == Schema Information
#
# Table name: campaigns
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  advertiser_id    :integer
#  name             :string           not null
#  start_date       :datetime
#  end_date         :datetime
#  alternative_id   :string
#  campaign_budget  :float
#  daily_budget     :float
#  budget_type      :integer
#  revenue_type     :integer
#  revenue_amount   :float
#  pacing           :integer
#  notes            :string
#  active           :boolean
#  beeswax_id       :integer
#  website_id       :integer
#  clickthrough_url :string
#
# Indexes
#
#  index_campaigns_on_advertiser_id  (advertiser_id)
#

require 'rails_helper'

RSpec.describe Campaign, type: :model do
	let(:advertiser) { create(:advertiser) }

  describe "properties" do
    it { expect(subject).to respond_to :name }
    it { expect(subject).to respond_to :advertiser }
    it { expect(subject).to respond_to :start_date }
    it { expect(subject).to respond_to :end_date }
  end

  describe "validations" do
	  it "requires name" do
		  expect {
			  Campaign.create(advertiser: advertiser, name: "").save!
		  }.to raise_error(ActiveRecord::RecordInvalid, /Name can't be blank/)
	  end
  end

  describe "relations" do
    it "belongs_to Advertiser" do
      expect(subject).to respond_to :advertiser
    end
    it "has_many LineItems" do
	    expect(subject).to respond_to :line_items
    end
  end

	describe "callbacks" do
		it "creates LineItem per Inventory Source" do
			expect { create(:campaign) }.to change(LineItem, :count).by(7)
		end
	end

end
