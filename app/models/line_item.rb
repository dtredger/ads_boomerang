# == Schema Information
#
# Table name: line_items
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  inventory_source :integer          not null
#  campaign_id      :integer          not null
#

class LineItem < ApplicationRecord

	belongs_to :campaign

	validates_associated :campaign

	enum inventory_source: {
		appnexus: 0,
		adx: 1,
		openx: 2,
		rubicon: 3,
		pulsepoint: 4,
		pubmatic: 5,
		rtkio: 6
  }



end
