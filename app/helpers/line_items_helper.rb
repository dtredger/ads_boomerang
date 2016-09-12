module LineItemsHelper

	def beeswax_countries
		Beeswax::Geo::COUNTRIES.map do |country|
			country['name']
		end
	end

	def beeswax_countries_data
		Beeswax::Geo::COUNTRIES
	end

	def iab_categories
		Beeswax::IabCategory::IAB_CATEGORIES
	end

end
