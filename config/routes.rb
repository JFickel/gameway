Gameway::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations" }

  resources :users
  resources :groups
  resources :group_memberships
  resources :starcraft2_accounts
  resources :twitch_accounts
  resources :events

  resources :tournaments do
    member do
      post 'start'
    end
  end
  resources :tournament_memberships
  resources :moderator_roles
  resources :broadcaster_roles
  resources :affiliations
  resources :invitations

  post 'slots', to: 'slots#create'
  delete 'slots', to: 'slots#destroy'

  post 'time_zones', to: 'time_zones#create'

  resources :teams
  resources :team_memberships
  root to: "home#index"

  # devise_for :users, :skip => [:sessions]
  devise_scope :user do
    get "/", :to => "devise/sessions#new" #, :as => :new_user_session
  #   post "/users/sign_in", to: "devise/sessions#create", as: :user_session
  #   delete "/users/sign_out", to: "devise/sessions#destroy", as: :destroy_user_session
    get "/", :to => "devise/registrations#new"
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
