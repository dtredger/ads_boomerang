require 'beeswax/base'

module Beeswax
	module Advertisable
		extend ActiveSupport::Concern

		included do
			before_validation :save_beeswax_advertiser

			validate :present_in_beeswax
		end

		def authenticate_beeswax
			Beeswax.api_user = ENV["BEESWAX_API_USER"]
			Beeswax.api_password = ENV["BEESWAX_API_PASSWORD"]
			Beeswax.authenticate
		end

		def save_beeswax_advertiser
			authenticate_beeswax
			if self.beeswax_id.nil?
				create_beeswax_advertiser
			else
				update_beeswax_advertiser
			end

		end

		def create_beeswax_advertiser
			response = Beeswax::Advertiser.create(
					alternative_id: website[0..19],
					advertiser_name: name,
					default_click_url: default_click_url,
					notes: notes )
			if response[:id].present?
				self.beeswax_id = response[:id]
				true
			else
				false
			end
		end

		def update_beeswax_advertiser
			response = Beeswax::Advertiser.update(
					alternative_id: email,
					advertiser_name: name,
					default_click_url: default_click_url,
					notes: notes )
			if response[:id].present?
				self.beeswax_id = response[:id]
				true
			else
				false
			end
		end

		def present_in_beeswax
			errors.add(:beeswax_id, :blank, message: "cannot be nil") if beeswax_id.nil?
		end

	end
end

