Rails.application.routes.draw do
  get 'page/homepage'
  get 'page/transactions'
  get 'page/login'
  get 'page/login2'
  get 'page/loanrequest'
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # https://dev.to/lucysuddenly/nested-comments-in-ruby-on-rails-1k1f
  resources :posts do
    resources :comments
  end

  resources :comments do
    resources :comments
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_scope :user do
    # Redirect signing out users back to sign in
    get "users", to: "devise/sessions#new"
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }



  # Defines the root path route ("/")
  root "posts#index"

end
