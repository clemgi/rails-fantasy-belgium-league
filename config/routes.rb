Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :squads, only: [:new, :create]

    resource :profile, only: [:show, :edit]

  namespace :profile do
    resource :squad, only: [:update, :edit, :show]
    resources :gameweeks, only: [:show]
    # resources :leagues
  end
end
