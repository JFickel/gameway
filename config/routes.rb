Gameway::Application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  root to: "assets#index"
  resources :tournaments
  resources :users
end
