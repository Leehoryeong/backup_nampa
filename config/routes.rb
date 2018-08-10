Rails.application.routes.draw do

  get 'reviews/create'

  get 'reviews/destroy'

  resources :userspecs
  devise_for :users
  root 'home#index'

  # manuals
  resources :manuals do
    resources :comments
  end

  # custom
  get 'custom/info'
  get 'custom/index'

  # ranking
  get 'ranking/index'

  # shopping
  get 'shopping/index'


  # product
  resources :products do
    resources :reviews
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
