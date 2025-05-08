Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users

  namespace :admin do
    get "templates/new"
    get "templates/show"
    get "templates/edit"
    get "/", to: "admin#index"

    resources :shows do
      member do
         get :attendees, to: "shows#attendees", as: :attendees
      end
      resources :polls
      resources :live_streams, except: [ :index ]
    end
    resources :settings, only: [ :index, :show, :edit, :update ]
    resources :users
    resources :attendees
    resources :templates
  end

  namespace :api do
    resources :shows, only: [ :index, :show, :update ] do
      member do
        patch "transition/:state", to: "shows#transition", as: :transition
      end

      resources :polls do
        member do
          patch "transition/:state", to: "polls#transition", as: :transition

          get "winner", to: "polls#winner", as: :winner
        end
        resources :choices
      end
    end
  end


  root to: "welcome#index"
  get "/log_out", to: "welcome#log_out", as: :log_out

  resources :shows, only: :show, param: :code
  resources :attendees, only: :create
  resources :votes, only: [ :create, :update ]

  # https://headey.net/rails-assets-active-storage-and-a-cloudfront-cdn
  direct :rails_public_blob do |blob|
    # Preserve the behaviour of `rails_blob_url` inside these environments
    # where S3 or the CDN might not be configured
    if ENV.fetch("ACTIVE_STORAGE_ASSET_HOST", false) && blob&.key
     File.join(ENV.fetch("ACTIVE_STORAGE_ASSET_HOST"), blob.key)
    else
     route =
       # ActiveStorage::VariantWithRecord was introduced in Rails 6.1
       # Remove the second check if you're using an older version
       if blob.is_a?(ActiveStorage::Variant) || blob.is_a?(ActiveStorage::VariantWithRecord)
          :rails_representation
       else
          :rails_blob
       end
     route_for(route, blob)
    end
  end
end
