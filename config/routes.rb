Rails.application.routes.draw do
  
  resources :skills
  get 'page/index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create' 
  delete '/logout', to: 'sessions#destroy'
  get  "/test" => "sessions#test"

  namespace :admin do
    resources :users do
      member do
        get :edit_proficiency
        patch :update_proficiency
      end
    end
  end
  root to: 'tasks#index'
  resources :tasks do
    post :confirm, action: :confirm_new, on: :new
  end

  resources :projects

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
