Rails.application.routes.draw do
  get 'kiruploads/index'

  get 'kiruploads/new'

  get 'kiruploads/create'

  get 'kiruploads/destroy'

  get 'hlauploads/index'

  get 'hlauploads/new'

  get 'hlauploads/create'

  get 'hlauploads/destroy'

  get 'hlas/index'

  get 'hlas/new'

  get 'hlas/create'

  get 'hlas/destroy'

  get 'dataview/index'

  get 'dataview/download_sample_data'

  get 'keys/index'

  get 'keys/new'

  get 'keys/create'

  get 'keys/destroy'

  get 'infographics/show'

  get 'admin_contact/new'

  get 'users/profile'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get 'welcome/index'

  root 'welcome#index'

  match '/contacts',     to: 'contacts#new',             via: 'get'
  resources "contacts", only: [:new, :create]

  resources 'keys', only: [:index, :new, :create, :destroy]

  resources 'hlauploads', only: [:index, :new, :create, :destroy]

  resources 'kiruploads', only: [:index, :new, :create, :destroy]

  resources 'dataview', only: [:index]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
