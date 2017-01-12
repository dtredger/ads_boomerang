# == Schema Information
#
# Table name: campaigns
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  advertiser_id    :integer
#  name             :string           not null
#  start_date       :datetime
#  end_date         :datetime
#  alternative_id   :string
#  campaign_budget  :float
#  daily_budget     :float
#  budget_type      :integer
#  revenue_type     :integer
#  revenue_amount   :float
#  pacing           :integer
#  notes            :string
#  active           :boolean
#  beeswax_id       :integer
#  website_id       :integer
#  clickthrough_url :string
#
# Indexes
#
#  index_campaigns_on_advertiser_id  (advertiser_id)
#

class Campaign < ApplicationRecord
	include Beeswax::Campaignable if beeswax_provider?
	include Beeswax::Segmentable if beeswax_provider?

	has_paper_trail

	default_scope { order('created_at DESC') }

	before_validation :set_campaign_start_date

	validates_presence_of :advertiser,
	                      :start_date,
	                      :website
	# validates_uniqueness_of :name, scope: :advertiser_id

  belongs_to :advertiser
	belongs_to :website
	has_many :creatives
	has_many :line_items
	has_many :segments
	has_one :include_segment, -> { where audience_type: 'add' }, class_name: Segment
	has_one :exclude_segment, -> { where audience_type: 'exclude' }, class_name: Segment

	before_create :set_default_clickthrough_url

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

	def last_week_labels
		if include_segment
			vals = []
			include_segment.seven_day_history.keys.each do |k|
				vals.push Date.parse(k).strftime("%b %d")
			end
			vals
		else
			[
				6.days.ago.strftime("%b %d"),
				5.days.ago.strftime("%b %d"),
				4.days.ago.strftime("%b %d"),
				3.days.ago.strftime("%b %d"),
				2.days.ago.strftime("%b %d"),
				Date.yesterday.strftime("%b %d"),
				Date.today.strftime("%b %d")
			]
		end
	end


	# TODO - check SubscriptionPLan (which should note audience size)
	def max_audience_history
		[ 500, 500, 500, 500, 500, 500, 500 ]
	end

	# TODO - these numbers are used in weekly graph: should be real numbers
	def addressable_audience_history
		return [ 0, 0, 0, 0, 0, 0, 0 ] unless include_segment
		include_segment.seven_day_history.values
	end

	def conversion_history
		[ 0, 0, 0, 0, 0, 0, 0 ]
	end


	private

		def set_campaign_start_date
			self.start_date = Time.now
		end

		def set_default_clickthrough_url
			self.clickthrough_url = website.homepage
		end

		def create_campaign_line_items
			LineItem.inventory_sources.each do |source_name, source_id|
				self.line_items.create(
						name: "#{name}_#{source_name}",
						inventory_source: source_id )
			end
		end

end


