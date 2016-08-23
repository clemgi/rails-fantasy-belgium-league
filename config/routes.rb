Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :squads, only: [:new]

    resource :profile, only: [:show, :edit]

  namespace :profile do
    resources :squads, only: [:create, :edit, :show]
    resources :leagues
  end
end
