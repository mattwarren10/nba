Rails.application.routes.draw do
	
  root :to => 'static#home'

  get 'players/index'

  get 'players/show'

end
