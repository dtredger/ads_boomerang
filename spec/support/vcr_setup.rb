require 'vcr'

VCR.configure do |config|
	config.cassette_library_dir = 'spec/support/cassettes'
	config.hook_into :webmock
	config.allow_http_connections_when_no_cassette = false
	config.ignore_localhost = true
	config.default_cassette_options = { record: :once }
	config.debug_logger = STDOUT if ENV['DEBUG']
end
