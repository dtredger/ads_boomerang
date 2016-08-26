# == Schema Information
#
# Table name: campaigns
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  advertiser_id :integer
#  name          :string           not null
#  start_date    :datetime
#  end_date      :datetime
#
# Indexes
#
#  index_campaigns_on_advertiser_id  (advertiser_id)
#

class Campaign < ApplicationRecord

	validates_presence_of :name

  belongs_to :advertiser
	has_many :line_items

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


	private

		def build_line_items
			INVENTORY_SOURCES.each do |source|
				self.line_items.create(inventory_source: source)
			end
		end

end
