Rails.application.routes.draw do

  resources :users, except: [:show]
  resources :votes, only: [:create, :destroy]

  resources :posts do
  	resources :comments, only: [:create, :edit, :update, :destroy], :shallow => true do
	  	resources :votes, only: [:create, :destroy]
	  end
  end	
  
  root 'welcome#index'
  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'
	get '/logout' => 'sessions#destroy'

end
