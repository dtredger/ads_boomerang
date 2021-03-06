# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.1'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')

Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.

Rails.application.config.assets.precompile += %w[
	base.js
	stylesheets/*
	javascripts/*
	stylesheets/pages/*
	javascripts/pages/*
	pages/*
	pages/base.css
	pages/partials/drop_template.css
	faq/*
	pricing/*
	mailers/*
	images/*
	images/chrome_top.png
	bootstrap-notify.js
	rollbar.js
]
