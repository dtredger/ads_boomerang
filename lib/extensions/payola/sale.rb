# module Extensions
# 	module Payola
# 		module Sale
# 			extend ActiveSupport::Concern
#
# 			module_eval do
# 				included do
# 					before_validation :set_affiliate
# 					before_validation :set_coupon
# 				end
# 			end
#
#
# 			def set_affiliate
# 				self.affiliate = ::Payola::Affiliate.first_or_create(code: 'dummy_affiliate')
# 			end
#
# 			def set_coupon
# 				self.coupon = ::Payola::Coupon.first_or_create(code:'dummy_coupon')
# 			end
#
# 		end
# 	end
# end
