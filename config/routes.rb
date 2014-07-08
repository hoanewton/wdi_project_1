Rails.application.routes.draw do

  resources :users, :comments, :posts, :votes 
  # get '/users/' => 'users#index'
  
  root 'welcome#index'
  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'
	get '/logout' => 'sessions#destroy'

end
