# == Schema Information
#
# Table name: creative_assets
#
#  id                     :integer          not null, primary key
#  advertiser_id          :integer
#  name                   :string
#  width                  :integer
#  height                 :integer
#  mounted_asset          :string
#  beeswax_asset_id       :integer
#  beeswax_alternative_id :string
#  notes                  :string
#  active                 :boolean
#  size_bytes             :integer
#  beeswax_asset_path     :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

FactoryGirl.define do
  factory :creative_asset do
	  advertiser
	  mounted_asset { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/support/level_end_300x250.jpg")) }

	  factory :creative_asset_728x90 do
		  sequence(:name) { |x| "728x90_creative_#{x}" }
		  mounted_asset { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/support/wedgie_728x90.png")) }
	  end

	  factory :creative_asset_160x600 do
		  sequence(:name) { |x| "160x600_creative_#{x}" }
		  mounted_asset { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/support/trashboat_160x600.png")) }
	  end

	  factory :beeswax_creative_asset do
		  beeswax_asset_id 100
		  beeswax_asset_path "stingersbx/94/38552/7890_level_end_300x250.jpg"
		  notes "beeswax notes!"
		  beeswax_alternative_id "a-beeswax-alt-id"
		  active true
		  after(:create) do |creative|
			  creative.update(name: creative.mounted_asset.filename,
			                  size_bytes: creative.mounted_asset.size )
		  end
	  end

  end
end
