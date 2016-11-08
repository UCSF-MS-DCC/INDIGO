Rails.application.routes.draw do
  get 'infographics/show'

  get 'admin_contact/new'

  get 'users/profile'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get 'welcome/index'

  root 'welcome#index'

  match '/contacts',     to: 'contacts#new',             via: 'get'
  resources "contacts", only: [:new, :create]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
