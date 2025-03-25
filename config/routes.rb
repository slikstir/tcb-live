Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users

  namespace :admin do
    get "/", to: "admin#index"

    resources :shows do 
      resources :attendees
      resources :polls
    end
    resources :users
    resources :attendees
  end

  
  root to: "welcome#index"
  resources :shows, only: :show
  resources :attendees, only: :create

end
