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

	before_create :write_page_categories

	after_create :start_campaign, if: :no_campaign?

	validates_presence_of :advertiser,
	                      :name,
	                      :domain_name
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

	# TODO - domain-name saves with protocol, so potential for 'http://http://...'
	def homepage
		"#{protocol}//#{self.domain_name}"
	end

	def tag_placed?
		return false unless self.pages && !self.pages.is_a?(Array)
		return false unless self.pages["all"] && self.domain_name
		if self.pages["all"].include?(self.homepage + "/?adsboomerangtest=verify") \
			|| self.pages["all"].include?(self.homepage+"?adsboomerangtest=verify") \
			|| self.pages["all"].include?(self.domain_name+"/?adsboomerangtest=verify") \
			|| self.pages["all"].include?(self.domain_name+"?adsboomerangtest=verify")
			true
		else
			false
		end
	end

	def get_segment(page_url)
		write_page_categories

		if self.pages["all"].exclude?(page_url)
			self.pages["all"].push(page_url)
			self.save
		end

		if self.pages["exclude"] && self.pages["exclude"].include?(page_url)
			campaign.exclude_segment.retarget_src if campaign.exclude_segment
		elsif self.pages["add"] && self.pages["add"].include?(page_url)
			campaign.include_segment.retarget_src if campaign.include_segment
		else
			nil
		end
	end

	def ready_to_launch?
		if self.tag_placed? && self.campaign && self.campaign.active? && self.campaign.creatives.any?
			true
		else
			false
		end
	end

	private

		def sufficient_subscription
			if advertiser && advertiser.websites.count > advertiser.max_websites
				errors.add(:advertiser, "You need to upgrade your subscription to create more websites")
			end
		end

		def no_campaign?
			self.campaign.nil?
		end

		def start_campaign
			Campaign.create(advertiser: self.advertiser,
			                website: self,
			                name: "#{self.name} campaign")
		end

		def write_page_categories
			return unless self.pages.nil?
			self.pages = {"all": [], "add": [], "exclude": []}
		end
end
