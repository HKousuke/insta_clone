Rails.application.routes.draw do
  root 'static_pages#introduction'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get '/signup',to:'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'auth/:provider/callback', to: 'sessions#create'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  resources :microposts , only: [:create , :destroy ] do
        resources :comments
  end
end
