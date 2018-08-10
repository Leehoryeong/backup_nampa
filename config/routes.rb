Rails.application.routes.draw do
  resources :user_specs
  devise_for :users
  root 'home#index'

  # manuals
  resources :manuals

  # custom
  get 'custom/info'
  get 'custom/index'

  # ranking
  get 'ranking/index'

  # shopping
  get 'shopping/index'


  # product
  resources :products


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
