Rails.application.routes.draw do
  devise_for :advertisers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  # authenticated :admin do
  #   root to: 'advertisers#index', as: :authenticated_admin
  # end

  authenticated :advertiser do
    root to: 'advertisers#show', as: :authenticated_advertiser

    resource :advertiser

    resources :campaign
    resources :creative
  end



  # root to: 'pages#home' # set in initializers/high_voltage
end
