# require Rails - https://github.com/tomykaira/clockwork
require_relative "../config/boot"
require_relative "../config/environment"

require 'clockwork'

module Clockwork
	handler do |job, time|
		Rails.logger.debug "running #{job} at #{time}"
		puts "running #{job} at #{time}"
	end

	# every(10.seconds, 'frequent.job') do
	# 	ApplicationJob.perform_later("fish")
	# end
	# every(3.minutes, 'less.frequent.job')
	# every(1.hour, 'hourly.job')
	#
	# every(1.day, 'midnight.job', :at => '00:00')

end
