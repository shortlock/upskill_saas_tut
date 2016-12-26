Rails.application.routes.draw do

  root to: 'pages#home'
  devise_for :users, controllers: { registrations: 'users/registrations'}
  resources :users do
    resource :profile
  end
  get 'about', to: 'pages#about'
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
  get 'admin', to: 'admins#index'
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  match 'profiles/:id' => 'profiles#destroy', :via => :delete, :as => :admin_destroy_profile


end
