Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    sessions: 'devise/sessions'
  }
  devise_scope :user do
    get 'users', to: 'users/registrations#index'
    get 'phone_numbers', to: 'users/registrations#new_phone_number'
    get 'signup_creditcards', to: 'users/registrations#signup_creditcard'
    get 'addresses', to: 'users/registrations#new_address'
    post 'signup_create', to: 'users/registrations#signup_create'
  end
  root to: 'items#index'
  resources :items do
    collection do
      get 'category_children'
      get 'category_grandchildren'
      get 'set_sizes'
      get 'set_brands'
      get 'cal_profit'
      get 'search'
      get 'detail_search'
    end
    resources :purchase do
      collection do
        get 'buy'
        post 'pay'
        get 'done'
        put 'transaction_comp'
      end
    end
    resources :comments, only: :create
    resources :likes, only: [:create, :destroy]
  end
  resources :test, only: :index
  resources :user_profiles, only: :index
  resources :creditcards, only: [:create, :new, :index, :show, :destroy]
  resources :users do
    member do
      get 'identification'
      get 'before_logout'
      get 'change_profile'
      get 'mypage'
      get 'purchase'
      get 'purchased'
      get 'show_selling_items'
      get 'show_transactions'
      get 'show_sold_items'
    end
  end
  resources :categories, only: [:index, :show]
  resources :graphs, only: [:index]
  resources :admin, only: [:index] do
    collection do
      get 'users_show'
      get 'items_show'
      get 'trading_show'
    end
    member do
      delete 'user_destroy'
      delete 'item_destroy'
    end
  end
end