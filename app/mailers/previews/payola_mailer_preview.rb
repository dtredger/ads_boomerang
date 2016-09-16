class Payola::MailerPreview < ActionMailer::Preview

	class Advertiser < Payola::MailerPreview
		def receipt
			mailer = Payola::ReceiptMailer
			mailer.receipt(Payola::Sale.last.guid)
		end

		def refund
			mailer = Payola::ReceiptMailer
			mailer.refund(Payola::Sale.last.guid)
		end
	end


	class Admin < Payola::MailerPreview
		def admin_receipt
			mailer = Payola::AdminMailer
			mailer.receipt(Payola::Sale.last.guid)
		end

		def admin_refund
			mailer = Payola::AdminMailer
			mailer.refund(Payola::Sale.last.guid)
		end

		def admin_dispute
			mailer = Payola::AdminMailer
			mailer.dispute(Payola::Sale.last.guid)
		end

		def admin_failure
			mailer = Payola::AdminMailer
			mailer.failure(Payola::Sale.last.guid)
		end
	end

end

# --- from payola.rb ---
# DEFAULT_EMAILS = {
# 		receipt:       [ 'payola.sale.finished', 'Payola::ReceiptMailer', :receipt ],
# 		refund:        [ 'charge.refunded',      'Payola::ReceiptMailer', :refund  ],
# 		admin_receipt: [ 'payola.sale.finished', 'Payola::AdminMailer',   :receipt ],
# 		admin_dispute: [ 'dispute.created',      'Payola::AdminMailer',   :dispute ],
# 		admin_refund:  [ 'payola.sale.refunded', 'Payola::AdminMailer',   :refund  ],
# 		admin_failure: [ 'payola.sale.failed',   'Payola::AdminMailer',   :failure ],
# }