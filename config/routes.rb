Gameway::Application.routes.draw do
  root to: "assets#index"
  resources :tournaments
end
