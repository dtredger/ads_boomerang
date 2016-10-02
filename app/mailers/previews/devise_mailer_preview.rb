class Devise::MailerPreview < ActionMailer::Preview


	# --- requires Confirmable module ---
	def confirmation_instructions
		Devise::Mailer.confirmation_instructions(Advertiser.first, "faketoken")
	end

	def reset_password_instructions
		Devise::Mailer.reset_password_instructions(Advertiser.first, "faketoken")
	end

	# def unlock_instructions
	# 	Devise::Mailer.unlock_instructions(Advertiser.first, "faketoken")
	# end

	def password_change
		Devise::Mailer.password_change(Advertiser.first)
	end

end
