Rails.application.routes.draw do
	

  devise_for :users
  root :to => 'static#home'

  # scope league and nest teams and players inside
  resources :static_players, only: [:index, :show]
  resources :static_teams, only: [:index, :show]

  

end
