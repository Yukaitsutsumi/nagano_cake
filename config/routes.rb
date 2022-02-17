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



  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'
  get 'items' => 'public/items#index'
  get 'items/:id' => 'public/items#show'
  get 'customers/may_page' => 'public/customers#show'
  get 'customers/edit' => 'public/customers#edit'
  patch 'customers/may_page' => 'public/customers#update'
  get 'customers/unsubscribe' => 'public/customers#unsubscribe'

  namespace :admin do
    get 'top' => 'homes#top'
    resources :items, except: [:destroy]
    resources :genres, except: [:destroy, :new, :show]
  end

end
