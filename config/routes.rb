Rails.application.routes.draw do
  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, controllers: {
      registrations:      "users/registrations",
      sessions:           "users/sessions",
      passwords:          "users/passwords",
      # omniauth_callbacks: "users/omniauth_callbacks"
  }, skip: [:sessions, :registrations]

  devise_for :admins, controllers: {
      registrations:      "admins/registrations",
      sessions:           "admins/sessions",
      passwords:          "admins/passwords"
  }, skip: [:sessions, :registrations]

  # You can have the root of your site routed with "root"
  root 'home#index'

  resource :contact, only: [:new, :create]

  scope :admin, module: 'admins', as: 'admin' do
    resources :admins
    resources :users
  end

  devise_scope :user do
    get    'welcome' => 'users/registrations#edit',   as: :user_root

    get    'login'   => "users/sessions#new",         as: :new_user_session
    post   'login'   => "users/sessions#create",      as: :user_session
    delete 'signout' => "users/sessions#destroy",     as: :destroy_user_session
           '       '
    get    'signup'  => "users/registrations#new",    as: :new_user_registration
    post   'signup'  => "users/registrations#create", as: :user_registration
    put    'signup'  => "users/registrations#update", as: :update_user_registration
    get    'account' => "users/registrations#edit",   as: :edit_user_registration
  end

  devise_scope :admin do
    get    'admin/welcome' => 'admins/registrations#edit',   as: :admin_root

    get    "admin"         => "admins/sessions#new",         as: :new_admin_session
    post   "admin/login"   => "admins/sessions#create",      as: :admin_session
    delete "admin/signout" => "admins/sessions#destroy",     as: :destroy_admin_session

    put    "admin/signup"  => "admins/registrations#update", as: :update_admin_registration
    get    "admin/account" => "admins/registrations#edit",   as: :edit_admin_registration
  end

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
