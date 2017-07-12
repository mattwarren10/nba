Rails.application.routes.draw do
	

  root :to => 'static#home'

  scope :fantasy do
  	# scope league and nest teams and players inside
  	resources :players, only: [:index, :show]
  	resources :teams, only: [:index, :show]
  end
  

end
