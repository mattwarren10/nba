Rails.application.routes.draw do

  devise_for :users
  root :to => 'static#home'

  # scope league and nest teams and players inside
  resources :players, only: [:index, :show]
  resources :teams, only: [:index, :show]

  

end
