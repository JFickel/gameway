Gameway::Application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    confirmations: "users/confirmations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  root to: "assets#index"
  resources :tournaments
  resources :users
end
