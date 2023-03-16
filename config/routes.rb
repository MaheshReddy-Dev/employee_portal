Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "projects#index"
  get "/index_projects/" =>'projects#index'
  post 'checkout/create' => 'checkout#create', as: "checkout_create"
  resources :webhooks, only: [:create]
  resources :projects do
   resources :tasks
  end
end
