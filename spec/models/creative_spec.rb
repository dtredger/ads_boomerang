# == Schema Information
#
# Table name: creatives
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  advertiser_id  :integer
#  name           :string           not null
#  creative_asset :string
#  width          :integer
#  height         :integer
#
# Indexes
#
#  index_creatives_on_advertiser_id  (advertiser_id)
#

require 'rails_helper'

RSpec.describe Creative, type: :model do
	let(:advertiser) { create(:advertiser) }

	describe "properties" do
		it { expect(subject).to respond_to :name }
		it { expect(subject).to respond_to :creative_asset }
	end

	describe "relations" do
		it "belongs_to Advertiser" do
			expect(subject).to respond_to :advertiser
		end
	end

	describe "validations" do
		pending "requires IAB size" do
			expect {
				Creative.new(advertiser: advertiser, name: "90x91 image",
				                creative_asset: Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/support/spacepup_91x90
.png"))
				).save!
			}.to raise_error(ActiveRecord::RecordInvalid, /image dimensions/)
		end
		it "requires name" do
			expect {
				create(:creative, name: "")
			}.to raise_error(ActiveRecord::RecordInvalid, /Name can't be blank/)
		end
	end
end
