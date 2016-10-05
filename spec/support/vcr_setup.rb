require 'vcr'

VCR.configure do |config|
	config.cassette_library_dir = 'spec/support/cassettes'
	config.hook_into :webmock
	config.allow_http_connections_when_no_cassette = true
	config.ignore_localhost = true
	config.default_cassette_options = {
			record: :once,
			allow_playback_repeats: true
	}
	config.debug_logger = STDOUT if ENV['DEBUG']
	config.filter_sensitive_data('<BEESWAX_API_USER>') { ENV["BEESWAX_API_USER"] }
	config.filter_sensitive_data('<BEESWAX_API_PASSWORD>') { ENV["BEESWAX_API_PASSWORD"] }
end
