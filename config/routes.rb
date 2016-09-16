require 'sidekiq/web'

Rails.application.routes.draw do

	# mount LetsencryptPlugin::Engine, at: '/'
  mount ForestLiana::Engine => '/forest'
  mount Payola::Engine => '/payola', as: :payola
	mount ActionCable.server => '/cable'
	Sidekiq::Web.use Rack::Auth::Basic do |username, password|
		username == ENV["SIDEKIQ_USERNAME"] && password == ENV["SIDEKIQ_PASSWORD"]
	end if Rails.env.production?
	mount Sidekiq::Web => '/sidekiq'

	# authenticated :admin do
  #   root to: 'advertisers#index', as: :authenticated_admin
  # end

	devise_for :advertisers, path: ""

  authenticated :advertiser do
    root to: 'advertisers#show', as: :authenticated_advertiser

    resource :advertiser, path: "account"

    resource :subscription, only: [:new, :create]

    resources :campaigns
    resources :creatives

  end

	get '/faq' => 'high_voltage/pages#show', id: 'faq'
	get '/pricing' => 'high_voltage/pages#show', id: 'pricing', as: :pricing

  # root to: 'pages#home' # set in initializers/high_voltage
  get '*path' => redirect('/')
end