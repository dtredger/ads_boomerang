Rails.application.routes.draw do
  devise_for :advertisers

  # authenticated :admin do
  #   root to: 'advertisers#index', as: :authenticated_admin
  # end

  authenticated :advertiser do
    root to: 'advertisers#show', as: :authenticated_advertiser

    resource :advertiser

    resources :campaigns
    resources :creatives
  end

  # root to: 'pages#home' # set in initializers/high_voltage

  get '*path' => redirect('/')
end
