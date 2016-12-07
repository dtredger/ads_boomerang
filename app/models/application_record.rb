class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  def log_failure(*args)
	  Rollbar.error(*args)
  end

  def self.beeswax_provider?
	  (ENV["INVENTORY_PROVIDER"] == "beeswax") ? true : false
  end
end
