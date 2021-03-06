# == Schema Information
#
# Table name: advertisers
#
#  id                     :integer          not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  subscription_plan_id   :integer
#  alternative_id         :string
#  conversion_method_id   :integer
#  default_click_url      :string
#  notes                  :string
#  beeswax_id             :integer
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#
# Indexes
#
#  index_advertisers_on_confirmation_token    (confirmation_token) UNIQUE
#  index_advertisers_on_email                 (email) UNIQUE
#  index_advertisers_on_reset_password_token  (reset_password_token) UNIQUE
#

class Advertiser < ApplicationRecord
	include Beeswax::Advertisable if beeswax_provider?

	has_paper_trail
	# mailkick_user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

	validates_presence_of :email

	has_many :websites
  has_many :campaigns
  has_many :segments, through: :campaigns
  has_many :creative_assets
  has_many :creatives, through: :creative_assets
  has_many :sales, through: :subscription,
           class_name: "Payola::Sale"
	has_one :subscription,
	        class_name: "Payola::Subscription",
	        foreign_key: "owner_id"
	# has_many :messages,
	#          class_name: "Ahoy::Message",
	#          foreign_key: "user_id"

	def active_website_tag?
		websites.each do |website|
			if website.tag_placed?
				return true
			end
		end
		false
	end

	def checklist_complete?
		if self.confirmed? && self.websites.any? \
				&& self.active_website_tag? && self.creatives.any? \
				&& self.campaigns.any? && self.subscription \
				&& self.subscription.active?
			true
		else
			false
		end
	end

	def total_audience
		add_segs = segments.where(audience_type: "add")
		total = 0
		add_segs.each do |seg|
			if seg.audience_history && seg.audience_history.keys.any?
				total += seg.audience_history[seg.audience_history.keys.last].to_i
			end
		end
		total
  end

	def name
		email
	end

	def default_click_url
		"#{protocol}://#{domain}"
	end

  def protocol
	  "http"
  end

  def domain
	  email.split("@")[1]
  end

	def max_websites
		1
	end


	def beeswax_attributes
		{ advertiser: {
				advertiser_domain: [domain],
				advertiser_category: ["IAB24"] }
		}
	end


	def send_devise_notification(notification, *args)
		devise_mailer.send(notification, self, *args).deliver_later
	end

end