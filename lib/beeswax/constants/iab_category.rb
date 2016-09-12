require 'json'

module Beeswax
	module IabCategory
		IAB_CATEGORIES = JSON.parse(
			File.read(
				File.join(File.dirname(__FILE__), "json/IAB-categories.json")
			)
		)
	end
end

