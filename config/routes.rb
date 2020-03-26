Rails.application.routes.draw do
  
  get 'page/index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create' 
  delete '/logout', to: 'sessions#destroy'
  get  "/test" => "sessions#test"

  namespace :admin do
    resources :users
  end
  root to: 'tasks#index'
  resources :tasks

  resources :projects
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
