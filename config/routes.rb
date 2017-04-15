Rails.application.routes.draw do
  resources :gwas
  resources :consensus_fastqs
  namespace :api do
    get 'v1/jsondata'
    get 'v1/rstudiodata'
  end

  get 'welcome/progress'

  get 'welcome/samples_table'

  get 'welcome/samples_summary_data'

  get 'welcome/dataset_stats'

  get 'welcome/dataset'

  get 'kiruploads/index'

  get 'kiruploads/new'

  get 'kiruploads/create'

  get 'hlauploads/index'

  get 'hlauploads/new'

  get 'hlauploads/create'

  get 'hlas/index'

  get 'hlas/new'

  get 'hlas/create'

  get 'dataview/index'

  get 'dataview/superindex'

  get 'dataview/download_sample_data'

  get 'dataview/download_hla_data'

  get 'dataview/download_kir_data'

  get 'dataview/download_idr'

  get 'dataview/samples_to_json'

  get 'dataview/hlas_to_json'

  get 'dataview/superindex_samples_to_json'

  get 'dataview/superindex_hlas_to_json'

  get 'keys/index'

  get 'keys/new'

  get 'keys/create'

  get 'profiles/show'

  get 'upload_reports/display'

  get 'upload_reports/show'

  post 'upload_reports/update'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get 'welcome/index'

  get 'welcome/next'

  get 'welcome/collaborators'

  get 'welcome/abstract'

  get 'welcome/progress'

  get 'welcome/samples_processed'

  root 'welcome#next'

  match '/contacts',     to: 'contacts#new',             via: 'get'
  resources "contacts", only: [:new, :create]

  resources 'keys', only: [:index, :new, :create]

  resources 'hlauploads', only: [:index, :new, :create]

  resources 'kiruploads', only: [:index, :new, :create]

  resources 'dataview', only: [:index]

  get 'nmdp_apis/test_gfe'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
