Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users

  namespace :admin do
    get "/", to: "admin#index"

    resources :shows do 
      member do 
         get :attendees, to: "shows#attendees", as: :attendees
      end
      resources :polls
    end
    resources :users
    resources :attendees
  end

  namespace :api do 
    resources :shows, only: [:index, :show, :update] do 
      resources :polls, only: [:index, :show, :update] do 
        resources :choices, only: [:index, :show, :create, :update, :destroy]
      end
    end
  end

  
  root to: "welcome#index"
  get '/log_out', to: "welcome#log_out", as: :log_out

  resources :shows, only: :show
  resources :attendees, only: :create
  resources :votes, only: [:create, :update]

end
