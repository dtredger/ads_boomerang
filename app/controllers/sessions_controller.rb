class SessionsController < Devise::SessionsController
	layout "pages/devise"

	def after_update_path_for(resource)
		authenticated_advertiser_path
	end

end
