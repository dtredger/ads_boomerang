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

end
