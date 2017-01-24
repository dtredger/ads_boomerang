require 'sidekiq/web'

Rails.application.routes.draw do

  mount ForestLiana::Engine => '/forest'
  mount Payola::Engine => '/payola', as: :payola

	# mount ActionCable.server => '/cable'

	Sidekiq::Web.use Rack::Auth::Basic do |username, password|
		username == ENV["SIDEKIQ_USERNAME"] && password == ENV["SIDEKIQ_PASSWORD"]
	end if Rails.env.production?
	mount Sidekiq::Web => '/sidekiq'

  # mount Mailkick::Engine => "/mailkick"
  # mount AhoyEmail::Engine => "/ahoy"

	# authenticated :admin do
  #   root to: 'advertisers#index', as: :authenticated_admin
  # end

  scope(path: "app") do
	  devise_for :advertisers, path: "", controllers: {
			                         registrations: "registrations",
			                         sessions: "sessions",
			                         confirmations: "confirmations",
			                         passwords: "passwords"
	                         }

	  authenticated :advertiser do
		  root to: 'advertisers#show', as: :authenticated_advertiser
		  get '/' => 'advertisers#show', as: :advertiser_root
		  resource :advertiser, path: "account"
		  resource :subscription, only: [:new, :create]
		  resources :websites
		  resources :campaigns do
			  resources :creatives
		  end
		  resources :creative_assets, path: "ad_library"
	  end
  end

	get '/faq' => 'high_voltage/pages#show', id: 'faq'
	get '/pricing' => 'high_voltage/pages#show', id: 'pricing'

	get '/.well-known/acme-challenge/H8oMhFnWgh6Zx2hXHTvk7ZWwNUPSAKl3GSGjnr0bQxo' => 'pages#letsencrypt'


	get '/survey' => redirect { |params, req| ENV["SURVEY_URL"] }
  # root to: 'pages#home' # set in initializers/high_voltage
  # TODO - figure out subscriptions path before enabling below:
  # explicitly mount mailkick engine?


  get '/px' => 'segments#tag', :constraints => { :format => 'js' }


  if Rails.env.production?
	  get '*path' => redirect('/')
  end

end
