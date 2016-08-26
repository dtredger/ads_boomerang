# == Schema Information
#
# Table name: line_items
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  inventory_source :integer          not null
#  campaign_id      :integer          not null
#

require 'rails_helper'

RSpec.describe LineItem, type: :model do
	describe "properties" do
		it { expect(subject).to respond_to :inventory_source }
	end

	describe "validations" do
		it "requires Campaign" do
			expect {
				LineItem.create(inventory_source: :adx).save!
			}.to raise_error(ActiveRecord::RecordInvalid, /Campaign must exist/)
		end
	end

	describe "relations" do
		it "belongs_to Campaign" do
			expect(subject).to respond_to :campaign
		end
	end
end
