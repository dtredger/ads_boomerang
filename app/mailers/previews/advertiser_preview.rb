# Preview all emails at http://localhost:3000/rails/mailers/advertiser
class AdvertiserPreview < ActionMailer::Preview

	# --- requires Confirmable module ---
	def confirmation_instructions
		AdvertiserMailer.confirmation_instructions(Advertiser.first, "faketoken")
	end

	def reset_password_instructions
		AdvertiserMailer.reset_password_instructions(Advertiser.first, "faketoken")
	end

	# def unlock_instructions
	# 	AdvertiserMailer.unlock_instructions(Advertiser.first, "faketoken")
	# end

	def password_change
		AdvertiserMailer.password_change(Advertiser.first)
	end
end
