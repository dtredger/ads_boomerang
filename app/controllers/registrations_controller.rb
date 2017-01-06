class RegistrationsController < Devise::RegistrationsController
	layout :resolve_layout

	private

		def resolve_layout
			case action_name
			when "edit", "update", "destroy"
				"application"
			else
				"pages/devise"
			end
		end

	def after_update_path_for(resource)
		authenticated_advertiser_path
	end

end
