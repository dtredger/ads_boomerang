source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'puma-heroku'
gem 'redis'
gem 'dalli'
gem "actionpack-action_caching"

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'bootstrap-sass'
gem 'bourbon'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'premailer-rails'
# gem 'ahoy_email'
# gem 'mailkick'

gem 'carrierwave'
gem 'fog'
gem 'fog-aws'
gem 'rack-cors', :require => 'rack/cors'
gem 'dropzonejs-rails'
# gem 'mercury-rails' TODO - rails generate mercury:install
# gem 'phrasing_plus'

gem 'httparty'
gem 'httmultiparty'

# TODO - required for sidekiq/web - https://github.com/mperham/sidekiq/issues/2960
gem 'sinatra', github: 'sinatra', require: false
# gem 'rack-protection', github: 'sinatra/rack-protection', require: false
gem 'sidekiq'
gem 'clockwork'
gem 'forest_liana'
gem 'customerio'
gem 'intercom'
gem 'intercom-rails'
gem 'hopscotch-rails'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'devise'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'annotate'
gem 'paper_trail'

gem 'high_voltage', github: 'thoughtbot/high_voltage'

gem 'payola-payments'
gem 'money-rails'

gem 'figaro'
gem 'rollbar'
gem 'newrelic_rpm'

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'byebug'
  gem 'pry'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem "awesome_print", require:"ap"
  gem 'webmock'
  gem 'vcr'
	gem 'letter_opener'
  gem "better_errors"
	gem 'binding_of_caller'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'meta_request'
end

group :production do
	gem 'platform-api', github: 'jalada/platform-api', branch: 'master'
	gem 'letsencrypt-rails-heroku'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
