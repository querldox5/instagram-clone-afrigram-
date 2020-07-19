Rails.application.routes.draw do
  # get 'users/login', :to => 'users#login'

  devise_for :users,
             path: 'accounts',
             path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration' },
             controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }

  root 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get '/users/:id', to: 'users#show'
  resources :users, only: [:show], path: 'accounts'

  resources :posts, only: %i[index show new create destroy]
end
