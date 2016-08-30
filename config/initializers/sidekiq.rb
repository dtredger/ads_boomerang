# https://github.com/mperham/sidekiq/wiki/Using-Redis

Sidekiq.configure_server do |config|
	config.redis = {
			url: ENV["REDISCLOUD_URL"],
			network_timeout: 5
	}
end

Sidekiq.configure_client do |config|
	config.redis = {
			url: ENV["REDISCLOUD_URL"],
			network_timeout: 5
	}
end
