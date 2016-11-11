class PagesController < ::HighVoltage::PagesController

	def letsencrypt
		# use your code here, not mine
		render text: ENV["SSL_KEY"]
	end

end
