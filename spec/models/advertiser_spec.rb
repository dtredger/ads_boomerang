# == Schema Information
#
# Table name: advertisers
#
#  id                     :integer          not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  subscription_plan_id   :integer
#  alternative_id         :string
#  conversion_method_id   :integer
#  default_click_url      :string
#  notes                  :string
#  beeswax_id             :integer
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#
# Indexes
#
#  index_advertisers_on_confirmation_token    (confirmation_token) UNIQUE
#  index_advertisers_on_email                 (email) UNIQUE
#  index_advertisers_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

RSpec.describe Advertiser, type: :model do
  describe "properties" do
	  it { expect(subject).to respond_to :email }
  end

  describe "relations" do
	  it "has_many Creatives" do
		  expect(subject).to respond_to :creatives
	  end
	  it "has_many Campaigns" do
		  expect(subject).to respond_to :campaigns
	  end
  end

  describe "#total_audience" do
	  let(:advertiser) { create(:advertiser) }
	  let(:segment_with_history) { create(:segment_with_history) }

	  it "defaults to 0" do
		  expect(advertiser.total_audience).to eq(0)
	  end

	  it "counts last day of audience" do
		  create(:beeswax_segment_campaign, advertiser: advertiser, include_segment: segment_with_history)
		  expect(advertiser.total_audience).to eq(992)
	  end

  end
end
