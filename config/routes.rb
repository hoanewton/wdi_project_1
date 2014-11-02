Rails.application.routes.draw do

  resources :users, except: [:show]
  # resources :votes, only: [:create, :destroy]

  resources :posts do
  	resources :comments, only: [:create, :edit, :update, :destroy], :shallow => true do
	  	resources :votes, only: [:create, :destroy]
	  end
  end	
  
  root 'application#index'
  get '*path' => 'application#index'

  get '/my_posts' => 'posts#my_posts'
  get '/sorted_posts' => 'posts#sorted_posts'
  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'
	get '/logout' => 'sessions#destroy'

end
