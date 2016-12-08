## See https://github.com/cyu/rack-cors

if defined? Rack::Cors
	Rails.configuration.middleware.insert_before 0, Rack::Cors do
		allow do
			origins %W(
								https://#{ENV[CDN_DOMAIN]}
								http://#{ENV[CDN_DOMAIN]}
								https://#{ENV[HOST]}
								http://#{ENV[HOST]}
								https://ads-boomerang-staging.herokuapp.com
								http://ads-boomerang-staging.herokuapp.com )
			resource '/assets/*'
		end
	end
end