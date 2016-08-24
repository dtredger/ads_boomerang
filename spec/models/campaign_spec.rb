# == Schema Information
#
# Table name: campaigns
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  advertiser_id :integer
#  name          :string           not null
#
# Indexes
#
#  index_campaigns_on_advertiser_id  (advertiser_id)
#

require 'rails_helper'

RSpec.describe Campaign, type: :model do

  describe "properties" do
    it { expect(subject).to respond_to :name }
  end

  describe "relations" do
    it "belongs_to Advertiser" do
      expect(subject).to respond_to :advertiser
    end
  end
end
