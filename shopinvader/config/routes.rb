Rails.application.routes.draw do

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get '/up', to: 'rails/health#show', as: :rails_health_check


  # Locomotive Back-office
  mount Locomotive::Engine => '/locomotive', as: 'locomotive' # you can change the value of the path, by default set to "/locomotive"

  # Locomotive API
  mount Locomotive::API.to_app => '/locomotive(/:site_handle)/api'

  # Render site
  mount Locomotive::Steam.to_app => '/', anchor: false
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
