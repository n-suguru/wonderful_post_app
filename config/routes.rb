Rails.application.routes.draw do
  resources :articles
  get '/mypage', to: 'mypage#show'
  get 'users/index'
  get 'users/show'
  devise_for :users
  root to: 'articles#index'
  # resources :articles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
