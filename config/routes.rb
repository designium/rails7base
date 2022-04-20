Rails.application.routes.draw do
  get 'page/homepage'
  get 'page/transactions'
  get 'page/login'
  get 'page/login2'
  get 'page/loanrequest'
  get 'page/shopping_product_listing'
  get 'page/shopping_category_page'
  get 'page/hotel_listing'
  get 'page/hotel_listing_details'
  get 'page/shopping_cart'
  get 'page/payment_step'
  get 'page/concert_listing'
  get 'page/concert_details'


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
