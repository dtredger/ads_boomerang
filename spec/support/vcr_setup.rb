require 'vcr'

VCR.configure do |c|
	c.cassette_library_dir = 'spec/support/cassettes'
	c.hook_into :webmock
	c.allow_http_connections_when_no_cassette = false
	c.ignore_localhost = true
	c.default_cassette_options = {record: :once}
	c.debug_logger = STDOUT if ENV['DEBUG']
end
