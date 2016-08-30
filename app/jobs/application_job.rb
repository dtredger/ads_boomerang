class ApplicationJob < ActiveJob::Base
	include Rollbar::ActiveJob

	def perform(args)
		Rails.logger.debug "Time now is #{Time.now}. Time from args is #{args}"
		puts "Time now is #{Time.now}. Time from args is #{args}"
	end

end
