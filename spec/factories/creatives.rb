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

FactoryGirl.define do
  factory :creative do
    sequence(:name) { |x| "creative_#{x}" }
    creative_asset { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/support/level_end_300x250.jpg")) }

    advertiser
  end
end
