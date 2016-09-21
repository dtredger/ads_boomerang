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
	include Beeswax::Campaignable
	include Beeswax::Segmentable

	validates_presence_of :advertiser
	validates_presence_of :name
	validates_uniqueness_of :name, scope: :advertiser_id

  belongs_to :advertiser
	has_many :line_items
	has_many :segments
	has_one :include_segment, -> { where audience: 'include' }, class_name: Segment
	has_one :exclude_segment, -> { where audience: 'exclude' }, class_name: Segment

	after_create :sync_with_beeswax
	after_create :create_campaign_segments
	after_create :create_campaign_line_items

	# enum budget_type: {
	# 		     spend: 0,
	# 		     impression: 1
	#      }


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
		# CPM vs Impression
		0
	end

	def revenue_type
		# Currently only `CPM` and `CPC` are supported.
		"CPM"
	end

	def revenue_amount
		ENV.fetch("REVENUE_AMOUNT") { 5.00 }.to_f
	end

	def click_url
		# TODO - allow individual creatives to have click_url?

	end


	private

		def create_campaign_line_items
			LineItem.inventory_source.each do |source_name, source_id|
				self.line_items.create(name: "#{name}_#{source_name}",inventory_source: source_id)
			end
		end

end


