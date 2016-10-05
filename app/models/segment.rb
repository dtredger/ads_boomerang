# == Schema Information
#
# Table name: segments
#
#  id             :integer          not null, primary key
#  beeswax_id     :integer
#  segment_name   :string
#  active         :boolean
#  alternative_id :string
#  campaign_id    :integer
#  segment_count  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  audience       :integer
#

class Segment < ApplicationRecord

	has_paper_trail

	validates_associated :campaign
	validates_presence_of :segment_name,
	                      :audience
	belongs_to :campaign

	enum audience: {
			     include: 0,
			     exclude: 1
	     }

	def segment_key
		"#{buzz_key}-#{beeswax_id}"
	end

	def segment_tag
		"<img src=\"http://segment.prod.bidr.io/associate-segment?buzz_key=#{buzz_key}&segment_key=#{segment_key}&value
=#{segment_value}\" height=\"0\" width=\"0\">"
	end

	def segment_value
		"[VALUE]"
	end

	def buzz_key
		"stingersbx"
	end


end
