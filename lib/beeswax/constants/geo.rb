# http://docs.beeswax.com/v0.5/docs/list-of-targeting-modules-and-keys

require 'json'

module Beeswax
  module Geo
    # ISO 3166-1 alpha-3
    COUNTRIES = JSON.parse(
      File.read(
        File.join(File.dirname(__FILE__), 'json/ISO-3166-countries.json')
      )
    )
  end
end
