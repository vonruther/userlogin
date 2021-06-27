Rails.application.routes.draw do
  resources :users do
    resources :comments
  end

	resources :posts do
    resources :comments
  end

  resources :members

  root 'sessions#new'
  
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
