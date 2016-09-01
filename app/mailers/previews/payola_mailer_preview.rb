class Payola::MailerPreview < ActionMailer::Preview


	# won't work because wants a Payola::Sale (with a product)
	def payola_receipt
		mailer = Payola::ReceiptMailer.new
		mailer.receipt(Payola::Sale.last.guid)
	end

	def payola_refund
		mailer = Payola::ReceiptMailer.new
		mailer.refund(Payola::Sale.last.guid)
	end

	def payola_admin_receipt
		mailer = Payola::AdminMailer.new
		mailer.receipt(Payola::Sale.last.guid)
	end

end


# Payola::ReceiptMailer #', :receipt
# Payola::ReceiptMailer #', :refund
# Payola::AdminMailer #',   :receipt
# Payola::AdminMailer #',   :dispute
# Payola::AdminMailer #',   :refund
# Payola::AdminMailer #',   :failure
# ---
# refund(sale_guid)
# dispute(sale_guid)
# failure(sale_guid)
