# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( base.js pages/home.js pages/home.scss pages/* stylesheets/pages/* javascripts/pages/* stylesheets/* javascripts/* faq/* pricing/* mailers/* bootstrap-notify.js rollbar.js pages/partials/drop_template.css pages/base
.css images/chrome_top.png)
