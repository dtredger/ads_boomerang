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
#
# Indexes
#
#  index_advertisers_on_email                 (email) UNIQUE
#  index_advertisers_on_reset_password_token  (reset_password_token) UNIQUE
#

class Advertiser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include Beeswax::Advertisable

  has_many :campaigns
  has_many :creatives

	has_one :subscription, class_name: "Payola::Subscription", foreign_key: "owner_id"


	def send_devise_notification(notification, *args)
		devise_mailer.send(notification, self, *args).deliver_later
	end

	def name
		email
	end

	def default_click_url
		website
	end

	def website
		email.split("@")[1]
	end

end
