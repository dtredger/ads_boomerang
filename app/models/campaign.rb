# == Schema Information
#
# Table name: campaigns
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  advertiser_id   :integer
#  name            :string           not null
#  start_date      :datetime
#  end_date        :datetime
#  alternative_id  :string
#  campaign_budget :float
#  daily_budget    :float
#  budget_type     :integer
#  revenue_type    :integer
#  revenue_amount  :float
#  pacing          :integer
#  notes           :string
#  active          :boolean
#  beeswax_id      :integer
#
# Indexes
#
#  index_campaigns_on_advertiser_id  (advertiser_id)
#

class Campaign < ApplicationRecord
	include BeeswaxCampaign

	validates_presence_of :name
	validates_uniqueness_of :name, scope: :advertiser_id

  belongs_to :advertiser
	has_many :line_items

	# enum budget_type: {
	# 		     spend: 0,
	# 		     impression: 1
	#      }

	def inventory_sources
		{
				appnexus: 9,
				adx: 0,
				openx: 10,
				rubicon: 6,
				pulsepoint: 5,
				pubmatic: 11,
				rtkio: 13
		}
	end

	after_create :build_line_items


	# TODO - alternative_id, frequency_cap, budget_type, revenue_type, pacing
	# 3600=hr, 86400=day, 604800=week
	def frequency_cap
		[{
				 impressions: 1,
				 duration: 3600
		 }, {
				 impressions: 2,
				 duration: 86400
		 }, {
				 impressions: 10,
				 duration: 604800
		 }]
	end

	def campaign_budget
		100.to_f
	end

	def daily_budget
		1.to_f
	end

	def budget_type
		0
	end

	def revenue_type
		# Currently only `CPM` and `CPC` are supported.
		"CPM"
	end

	def revenue_amount
		ENV.fetch("REVENUE_AMOUNT") { 5.00 }.to_f
	end

	def include_audience_segment
		"stingersbx-4842"
	end

	def exclude_audience_segment
		"stingersbx-4843"
	end

	private

		def build_line_items
			inventory_sources.each do |source_key, source_name|
				self.line_items.create(name: "#{name}_#{source_name}",inventory_source: source_key)
			end
		end

end


