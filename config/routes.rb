Rails.application.routes.draw do
  root to: 'pages#home'
  ActiveAdmin.routes(self)

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations'  }

  # resources :squads, only: [:index, :show]


  resources :teams, only: [:show]

  namespace :account do
    resource :profile, only: [:show, :edit, :update]
    resource :squad,   only: [:show, :new, :create, :edit, :update] do
      member do
        get :selection
        get :lineup
      end
    end
    
    resources :leagues, only: [:index, :show]

    resources :league_players, only: [:create]

    resources :squad_players, only: [:create, :destroy]
    resources :gameweeks, only: [:index, :show]
  end
end
