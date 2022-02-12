Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers

  namespace :public do
    get 'top' => 'homes#top'
    get 'about' => 'homes#about'
    get 'index' => 'items#index'
  end

  namespace :admin do
    get 'top' => 'homes#top'
    resources :items
  end

end
