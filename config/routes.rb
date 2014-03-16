Gameway::Application.routes.draw do
  devise_for :users
  root to: "assets#index"
  resources :tournaments
end
