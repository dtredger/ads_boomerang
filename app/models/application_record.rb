class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  def log_failure(*args)
	  Rollbar.error(*args)
  end
end
