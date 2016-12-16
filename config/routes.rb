Rails.application.routes.draw do
  root to: 'visitors#index'

  ActiveAdmin.routes(self)
  mount_devise_token_auth_for "User", at: "auth"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :guest_sessions
      resources :facebook_sessions
      namespace :my do
        resources :queries
        resources :conversations
      end
    end
  end

  resources :messages
  resources :conversations

  resources :password_reset_requests
  resources :recommend_keywords
  resources :contents
  resources :categories
  namespace :excel do
    resources :recommend_keywords
  end

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :session_signin
  get '/signout' => 'sessions#destroy', :as => :session_signout
  get '/auth/failure' => 'sessions#failure'
end
