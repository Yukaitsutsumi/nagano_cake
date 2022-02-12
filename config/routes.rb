Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers
  
  namespace :public do
    get 'top' => 'homes#top'
    get 'about' => 'homes#about'
  end

end
