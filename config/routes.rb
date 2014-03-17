Gameway::Application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }
  root to: "assets#index"
  resources :tournaments
end
