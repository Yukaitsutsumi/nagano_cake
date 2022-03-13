Rails.application.routes.draw do

  devise_for :admin, controllers: {
   sessions: "admin/sessions"
  }

  devise_for :customers, skip: :all
  devise_scope :customer do
    get '/customers/sign_up' => 'public/registrations#new', as: :new_customer_registration
    post '/customers' => 'public/registrations#create', as: :customer_registration
    get '/customers/sign_in' => 'public/sessions#new', as: :new_customer_session
    post '/customers/sign_in' => 'public/sessions#create', as: :customer_session
    delete '/customers/sign_out' => 'public/sessions#destroy', as: :destroy_customer_session
  end

  namespace :admin do
    get '/' => 'homes#top'
    resources :items, except: [:destroy]
    resources :genres, except: [:destroy, :new, :show]
    resources :customers, only: [:index, :show, :edit, :update] do
      resources :orders, only: [:index]
    end
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'

  get 'items' => 'public/items#index'
  get 'items/:id' => 'public/items#show', as: :show_item
  get 'search' => 'public/items#search'

  get 'customers/my_page' => 'public/customers#show'
  get 'customers/edit' => 'public/customers#edit'
  patch 'customers/my_page' => 'public/customers#update'
  get 'customers/unsubscribe' => 'public/customers#unsubscribe'
  patch 'customers/withdraw' => 'public/customers#withdraw'

  get 'cart_items' => 'public/cart_items#index'
  patch 'cart_items/:id' => 'public/cart_items#update', as: :cart_item
  post 'cart_items' => 'public/cart_items#create'
  delete 'cart_items/destroy_all' => 'public/cart_items#destroy_all'
  delete 'cart_items/:id' => 'public/cart_items#destroy', as: 'destroy_cart_item'

  get 'orders/new' => 'public/orders#new'
  post 'orders/confirm' => 'public/orders#confirm'
  get 'orders/complete' => 'public/orders#complete'
  post 'orders' => 'public/orders#create'
  get 'orders' => 'public/orders#index'
  get 'orders/:id' => 'public/orders#show', as: :show_order

  get 'addresses' => 'public/addresses#index', as: 'public_addresses'
  post 'addresses' => 'public/addresses#create'
  get 'addresses/:id/edit' => 'public/addresses#edit', as: 'edit_public_address'
  patch 'addresses/:id' => 'public/addresses#update', as: 'public_address'
  delete 'addresses/:id' => 'public/addresses#destroy', as: 'destroy_public_address'

end