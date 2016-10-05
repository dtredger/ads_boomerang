require 'beeswax/base'

Beeswax.environment  = ENV.fetch("BEESWAX_ENVIRONMENT") { "sandbox" }.to_sym
Beeswax.api_user     = ENV["BEESWAX_API_USER"]
Beeswax.api_password = ENV["BEESWAX_API_PASSWORD"]
