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

module AdsBoomerang
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

	  # Ignore bad email addresses and do not raise email delivery errors.
	  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
	  config.action_mailer.raise_delivery_errors = true
	  config.action_mailer.smtp_settings = {
			  :authentication => :plain,
			  :address => "smtp.mailgun.org",
			  :port => 587,
			  :domain => ENV["MAILGUN_DOMAIN"],
			  :user_name => ENV["MAILGUN_LOGIN"],
			  :password => ENV["MAILGUN_PASSWORD"]
	  }
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
