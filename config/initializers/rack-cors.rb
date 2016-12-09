## See https://github.com/cyu/rack-cors

if defined? Rack::Cors
	Rails.configuration.middleware.insert_before 0, Rack::Cors do
		allow do
			origins [
                "https://d1idnqjey0zziz.cloudfront.net",
								"http://d1idnqjey0zziz.cloudfront.net",
                "https://adsboomerang.com",
                "http://adsboomerang.com",
                "https://ads-boomerang-staging.herokuapp.com",
                "http://ads-boomerang-staging.herokuapp.com"
            ]
			resource '/assets/*'
		end
	end
end