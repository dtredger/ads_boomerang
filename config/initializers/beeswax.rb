if defined? Beeswax
	Beeswax.environment  = :sandbox #Rails.env.production? ? :live : :sandbox
	Beeswax.api_user     = ENV["BEESWAX_API_USER"]
	Beeswax.api_password = ENV["BEESWAX_API_PASSWORD"]
end
