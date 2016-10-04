module ApplicationCable
  class Connection < ActionCable::Connection::Base

		identified_by :current_advertiser

		def connect
			self.current_advertiser = find_active_advertiser
		end

		protected

			def find_active_advertiser
				return env['warden'].user if env['warden'].user
				reject_unauthorized_connection
			end


  end
end
