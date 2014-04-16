Gameway::Application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    confirmations: "users/confirmations",
    omniauth_callbacks: "users/omniauth_callbacks",
    passwords: "users/passwords"
  }
  root to: "assets#index"
  post '/matches/advance', to: 'matches#advance'
  resources :tournaments
  resources :competitorships
  resources :brackets
  resources :users
  resources :lol_accounts
  resources :teams
end
