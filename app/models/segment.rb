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
#  audience_type    :integer
#  manual_image_src :string
#  audience_history :json


class Segment < ApplicationRecord
	has_paper_trail

	validates_associated :campaign
	validates_presence_of :segment_name,
	                      :audience_type
	belongs_to :campaign

	enum audience_type: {
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

	def seven_day_history
		return unless audience_history
		audience_history.slice(
				(Date.today - 6).to_s,
				(Date.today - 5).to_s,
				(Date.today - 4).to_s,
				(Date.today - 3).to_s,
				(Date.today - 2).to_s,
				(Date.today - 1).to_s,
				Date.today.to_s
		).as_json
	end

	private

		def beeswax_src
			"https://segment.prod.bidr.io/associate-segment?buzz_key=#{buzz_key}&segment_key=#{segment_key}&value=#{segment_value}"
		end

end
