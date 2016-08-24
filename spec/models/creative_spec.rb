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
#
# Indexes
#
#  index_creatives_on_advertiser_id  (advertiser_id)
#

require 'rails_helper'

RSpec.describe Creative, type: :model do

	describe "properties" do
		it "requires name" do
			expect {
				create(:creative, name: "")
			}.to raise_error(ActiveRecord::RecordInvalid)
		end
		it { expect(subject).to respond_to :creative_asset }
	end

	describe "relations" do
		it "belongs_to Advertiser" do
			expect(subject).to respond_to :advertiser
		end
	end
end
