Gameway::Application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    confirmations: "users/confirmations"
  }
  root to: "assets#index"
  resources :tournaments
  resources :users
end
