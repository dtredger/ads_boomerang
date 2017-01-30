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

	after_create :start_campaign_if_none

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
		"<script>var s=document.createElement('script');var u=''+document.location;s.setAttribute('src','https://#{ENV['HOST']}/px.js?id=#{self.id}&s='+u);document.head.appendChild(s);</script>"
	end

	def protocol
		"http:"
	end

	def homepage
		"#{protocol}//#{self.domain_name}"
	end

	def tag_placed?
		return false unless self.pages
		if self.pages.include?(self.homepage + "/?adsboomerangtest=verify") \
			|| self.pages.include?(self.homepage+"?adsboomerangtest=verify") \
			|| self.pages.include?(self.domain_name+"/?adsboomerangtest=verify") \
			|| self.pages.include?(self.domain_name+"?adsboomerangtest=verify")
			true
		else
			false
		end
	end



	private

		def sufficient_subscription
			if advertiser.websites.count > advertiser.max_websites
				errors.add(:advertiser, "You need to upgrade your subscription to create more websites")
			end
		end

		def start_campaign_if_none
			Campaign.create(advertiser: self.advertiser,
			                website: self,
			                name: "#{self.name} campaign")
		end

end
