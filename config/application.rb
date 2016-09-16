require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AdsDash
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

	  config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
	  config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/

    config.generators do |g|
      g.view_specs false
      g.request_specs false
      g.routing_specs false

      g.javascript_engine :js
    end

    # overridden in development and production
    config.active_job.queue_adapter = :inline

	  # Ignore bad email addresses and do not raise email delivery errors.
	  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
	  config.action_mailer.raise_delivery_errors = true
	  #
	  # config.action_mailer.delivery_method = :smtp
	  # config.action_mailer.smtp_settings = {
			#   address:        "smtp.sparkpostmail.com",
			#   port:           "587",
			#   authentication: :plain,
			#   user_name:      "SMTP_Injection",
			#   password:       ENV["SPARKPOST_API_KEY"],
			#   domain:         ENV["HOSTNAME"],
			#   enable_starttls_auto: true
	  # }
	  #
	  # config.action_mailer.default_url_options = {
			#   :host => ENV['HOST_URL'] || "app..com",
			#   :protocol => ENV['HOST_PROTOCOL'] || 'http'
	  # }
	  #
	  # config.action_mailer.asset_host = (ENV['HOST_PROTOCOL'] || 'http') +
			#   '://' +
			#   (ENV['HOST_URL'] || "app..com")


  end
end
