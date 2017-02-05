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

FactoryGirl.define do
  factory :website do
    name "test website"
	  domain_name "http://test.com"
    provider "other"
    pages {}

	  advertiser
	  # campaign #created through callback
  end
end
