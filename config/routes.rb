Rails.application.routes.draw do
  get 'user/manager'
  get 'user/manager'
  devise_for :users
  root 'home#index'
  resources :users do
    member do
      put 'block_multiple', to: 'user#block_multiple'
      put 'block', to: 'user#block'
      put 'unblock', to: 'user#unblock'
      put 'add_admin', to: 'user#add_admin'
      put 'remove_admin', to: 'user#remove_admin'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
