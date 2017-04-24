class PagesController < ApplicationController
	include HighVoltage::StaticPage

	before_action :allow_page_caching, only: :show


	def letsencrypt
		# old - render text: "H8oMhFnWgh6Zx2hXHTvk7ZWwNUPSAKl3GSGjnr0bQxo.Dhcr_HFPDeEhbERa2Q6_yQ5DRHZk1xQtL-nTzew111c"
		render text: "iDoVXjt0WnN6nPJVAmCmdfYZuxXbe70TmoBhEbEgXVM.Dhcr_HFPDeEhbERa2Q6_yQ5DRHZk1xQtL-nTzew111c"
	end

	private

		def allow_page_caching
			expires_in(24.hours, public: true)
		end

end
