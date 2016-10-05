require 'beeswax/base'

Beeswax.environment  = ENV["BEESWAX_ENVIRONMENT"].to_sym
Beeswax.api_user     = ENV["BEESWAX_API_USER"]
Beeswax.api_password = ENV["BEESWAX_API_PASSWORD"]
