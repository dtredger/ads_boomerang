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
#
# Indexes
#
#  index_campaigns_on_advertiser_id  (advertiser_id)
#

class Campaign < ApplicationRecord
	include BeeswaxCampaign

	validates_presence_of :name

  belongs_to :advertiser
	has_many :line_items

	# enum budget_type: {
	# 		     spend: 0,
	# 		     impression: 1
	#      }

	INVENTORY_SOURCES = [
			:appnexus,
	    :adx,
	    :openx,
			:rubicon,
	    :pulsepoint,
	    :pubmatic,
	    :rtkio
	]

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

	private

		def build_line_items
			INVENTORY_SOURCES.each do |source|
				self.line_items.create(inventory_source: source)
			end
		end

end


