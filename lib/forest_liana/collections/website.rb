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

class Forest::Website
	include ForestLiana::Collection

	collection :websites
	action 'create_segments'

	field "All Pages", type: 'Json' do
		if object.pages && !object.pages.is_a?(Array) && object.pages["all"]
			object.pages["all"]
		end
	end
	field "include_segment ID", type: "Relation" do
		object.campaign.include_segment.id if object.campaign && object.campaign.include_segment
	end
	field "exclude_segment ID", type: "Integer" do
		object.campaign.exclude_segment.id if object.campaign && object.campaign.exclude_segment
	end
end
