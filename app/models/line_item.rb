# == Schema Information
#
# Table name: line_items
#
#  id                    :integer          not null, primary key
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  inventory_source      :integer          not null
#  campaign_id           :integer          not null
#  name                  :string
#  beeswax_id            :integer
#  alternative_id        :string
#  line_item_type_id     :integer
#  targeting_template_id :integer
#  line_item_budget      :float
#  daily_budget          :float
#  budget_type           :integer
#  notes                 :string
#  active                :boolean
#

class LineItem < ApplicationRecord
	include Beeswax::LineItemable

	belongs_to :campaign

	validates_presence_of :name
	validates_associated :campaign

	enum inventory_source: {
			appnexus: 9,
			adx: 0,
			openx: 10,
			rubicon: 6,
			pulsepoint: 5,
			pubmatic: 11,
			rtkio: 13
  }

	def inventory_id
		self.class.inventory_sources[inventory_source]
	end

	# 0=banner, 1=video.
	def line_item_type_id
		0
	end

	def line_item_budget
		campaign.campaign_budget / campaign.inventory_sources.length
	end

	def daily_budget
		campaign.daily_budget / campaign.inventory_sources.length
	end

	#  0=spend, 1=impressions
	def budget_type
		0
	end

	def strategy_id
		# 1=banner 2=video
		1
	end

	def bidding(cpm=1.00)
		{"bidding_strategy": "cpm", "values": {"cpm_bid": cpm} }
	end

	def start_date
		campaign.start_date
	end

	def end_date
		campaign.end_date
	end

	def active
		campaign.active?
	end



end
