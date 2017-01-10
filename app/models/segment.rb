# == Schema Information
#
# Table name: segments
#
#  id               :integer          not null, primary key
#  beeswax_id       :integer
#  segment_name     :string
#  active           :boolean
#  alternative_id   :string
#  campaign_id      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  audience         :integer
#  audience_count   :integer
#  manual_image_src :string
#

class Segment < ApplicationRecord
	has_paper_trail

	validates_associated :campaign
	validates_presence_of :segment_name,
	                      :audience
	belongs_to :campaign

	enum audience: {
			     add: 0,
			     exclude: 1
	     }

	def segment_key
		"#{buzz_key}-#{beeswax_id}"
	end

	def segment_tag
		"<script>var s=document.createElement('script');var u=''+document.location;s.setAttribute('src','https://#{ENV['HOST']}/px.js?d='+u);s.setAttribute('async', '');document.head.appendChild(s);</script>"
	end

	def retarget_src
		if self.beeswax_id
			beeswax_src
		else
			manual_image_src
		end
	end

	def segment_value
		"[VALUE]"
	end

	def buzz_key
		"stingersbx"
	end

	private

		def beeswax_src
			"https://segment.prod.bidr.io/associate-segment?buzz_key=#{buzz_key}&segment_key=#{segment_key}&value=#{segment_value}"
		end

end
