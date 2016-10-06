# class Payola::ReceiptMailer < ::Payola::ReceiptMailer
# 	layout "mailer"
# end

module Extensions
	module Payola
		module MailerLayout
			extend ActiveSupport::Concern

			module_eval do
				included do
					layout "mailers/base"
				end
			end

		end
	end
end