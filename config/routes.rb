Rails.application.routes.draw do

  resources :order_details
  resources :notifications
  resources :orders do
    resources :items
  end
  get 'follows/index'

  get 'home/index'
  get 'all' => 'users#all'
  get '/complete/:id', to: 'orders#complete'
  get '/join/:id', to: 'order_details#join'
  # match 'add', to: 'order_details#add', via: [:post]
  # post 'invite' => 'users#invite'
  # match 'invites', to: 'users#invite', via: [:post]

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  mount ActionCable.server => '/cable'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users do
     resources :groups
  end
  resources :groups

  resources :groups do
    member do
      post :new_member
      delete :delete_member
     # post '/newfollow', to: 'users#newfollow'
    end
 end

  resources :follows
 match 'users/newfollow' => 'users#newfollow', :via => :post
  resources :users do
     member do
       get :follow
       get :unfollow
      # post '/newfollow', to: 'users#newfollow'
     end
  end
 #root 'users#index'
 root  'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
