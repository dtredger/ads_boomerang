class ApplicationJob < ActiveJob::Base
	include Rollbar::ActiveJob

	def perform(args)
		Rails.logger.debug "Job ran at #{Time.now} with Args: #{args}"
	end

end
