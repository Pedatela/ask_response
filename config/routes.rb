Rails.application.routes.draw do
  namespace :admins_backoffice do
    resources :admins, except: [:delete]
    get 'welcome/index'
  end
  namespace :site do
    get 'welcome/index'
  end
  namespace :users_backoffice do
    get 'welcome/index'
  end
  
  devise_for :users
  devise_for :admins
  get 'site/welcome/index'
  root 'site/welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
