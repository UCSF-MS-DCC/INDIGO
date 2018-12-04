Rails.application.routes.draw do
  devise_for :users
  resources :notes
  resources :gwas
  resources :consensus_fastqs
  namespace :api do
    get 'v1/jsondata'
    get 'v1/rstudiodata'
    get 'v1/genesdata'
    get 'v2/sample'
    get 'v2/hla'
    get 'v2/kir'
    post 'v2/kir_pipeline'
  end
  get 'chart/index'
  get 'chart/index_panel_one_data'
  get 'chart/index_panel_two_data'
  get 'chart/index_panel_three_data'
  get 'chart/index_panel_four_data'

  get 'topics/index'

  get 'welcome/progress'

  get 'welcome/samples_table'

  get 'welcome/samples_summary_data'

  get 'welcome/dataset_stats'

  get 'welcome/dataset'

  get 'welcome/collaborator_status'

  get 'welcome/site_samples_progress'

  get 'hlas/index'

  get 'hlas/new'

  get 'hlas/create'

  get 'dataview/index'

  get 'dataview/superindex'

  get 'dataview/stacy'

  get 'dataview/sample_status'

  get 'dataview/samples_index'

  get 'dataview/hla_index'

  get 'dataview/kir_index'

  get 'dataview/samples_superindex'

  get 'dataview/hla_superindex'

  get 'dataview/kir_superindex'

  get 'dataview/modal_content'

  get 'dataview/download_sample_data'

  get 'dataview/download_hla_data'

  get 'dataview/download_kir_data'

  get 'dataview/download_hla_data_superuser'

  get 'dataview/download_kir_data_superuser'

  get 'dataview/download_all_data_superuser'

  get 'dataview/download_idr'

  get 'dataview/samples_to_json'

  get 'dataview/hlas_to_json'

  get 'dataview/kirs_to_json'

  get 'dataview/single_kir_genotype_version_table'

  get 'dataview/single_kir_wip_versions_data'

  get 'dataview/superindex_samples_to_json'

  get 'dataview/superindex_hlas_to_json'

  get 'dataview/superindex_kirs_to_json'

  get 'dataview/kir_genotyping_work_in_progress'

  get 'dataview/kir_wip_data'

  get 'dataview/method_version'

  get 'dataview/method_version_data'

  get 'dataview/allele_frequencies'

  get 'dataview/allele_frequencies_data'

  get 'profiles/show'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get 'welcome/index'

  get 'welcome/next'

  get 'welcome/collaborators'

  get 'welcome/abstract'

  get 'welcome/progress'

  get 'welcome/samples_processed'

  root 'welcome#next'

  resources 'dataview', only: [:index]

  get 'nmdp_apis/test_gfe'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
