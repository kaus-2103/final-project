Rails.application.routes.draw do


  scope "(:locale)", locale: /en|ru/ do
      get 'set_theme', to: 'home#update'
      get 'search', to: 'home#search', as: 'search_items'
      get 'user/profile'
      post 'user/create_client', to: 'user#create_client'
      post 'tickets/create', to: 'tickets#create'
      get 'tickets/new', to: 'tickets#new'
      get 'item/new'
      get 'collection/new'
      get 'item/history'
      get '/item/:id', to: 'item#show', as: 'item'
      get 'user/manager'
      get 'user/collection_item_manager'
      get 'items_by_category/:category', to: 'home#items_by_category', as: 'items_by_category_home'
      get 'items/category/:category', to: 'item#category', as: 'items_by_category'
      devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
    root 'home#index'
    

    resources :item do
      resources :comments, only: [:create]
      resource :like, only: [:create, :destroy]
    end

   

    resources :collection, only: [:new, :create, :show, :edit, :destroy, :update] do
      resources :item, only: [:new, :create, :destroy, :update, :edit, :history, :show]
        collection do
         get 'history', to: 'item#history'
      end
    end

    resources :users, only: [:manager] do
      member do
        put 'block_multiple', to: 'user#block_multiple'
        put 'block', to: 'user#block'
        put 'unblock', to: 'user#unblock'
        put 'add_admin', to: 'user#add_admin'
        put 'remove_admin', to: 'user#remove_admin'
        delete 'delete', to: 'user#destroy'
      end
    
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
