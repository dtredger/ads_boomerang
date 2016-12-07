# == Schema Information
#
# Table name: websites
#
#  id               :integer          not null, primary key
#  name             :string
#  domain_name      :string
#  provider         :integer
#  pages            :json
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  hosting_provider :integer
#  notes            :string
#  advertiser_id    :integer
#

class Website < ApplicationRecord
	belongs_to :advertiser
	has_one :campaign

	validates_presence_of :advertiser
	validate :sufficient_subscription

	enum hosting_provider: {
			     other: 0,
	         shopify: 1,
	         squarespace: 2,
	         wordpress: 3,
			     volusion: 4,
	         wix: 5,
	         woocommerce: 6,
	         cargo_collective: 7,
			     bigcartel: 8
	     }

	def website_tag
		"<script>var s=document.createElement('script');var u=''+document.location;s.setAttribute('src','https://#{ENV['HOST']}/px.js?d='+u);document.head.appendChild(s);</script>"
	end

	def protocol
		"http:"
	end

	def homepage
		if pages && pages[0]
			pages[0]
		else
			"#{protocol}//#{self.domain_name}"
		end
	end



	private

		def sufficient_subscription
			if advertiser.websites.count == advertiser.max_websites
				errors.add(:advertiser, "You need to upgrade your subscription to create more websites")
			end
		end

end
