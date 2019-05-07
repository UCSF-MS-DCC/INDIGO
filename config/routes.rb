Rails.application.routes.draw do
  devise_for :users
  resources :notes
  resources :gwas
  resources :consensus_fastqs

  root 'welcome#index'

  namespace :api do
    get 'v1/jsondata'
    get 'v1/rstudiodata'
    get 'v1/genesdata'
    get 'v2/sample'
    get 'v2/hla'
    get 'v2/kir'
    post 'v2/kir_pipeline'
  end

  namespace :chart do
    get 'processing'
    get 'index_panel_one_data'
    get 'index_panel_two_data'
    get 'index_panel_three_data'
    get 'index_panel_four_data'
  end

  get 'topics/index'

  namespace :welcome do
    get 'progress'
    get 'samples_table'
    get 'samples_summary_table'
    get 'dataset_stats'
    get 'dataset'
    get 'collaborator_status'
    get 'site_samples_progress'
    get 'collaborators'
    get 'abstract'
    get 'progress'
    get 'samples_processed'
  end

  get 'dataview/index'
  get 'dataview/superindex'
  get 'dataview/superindex_race_graph'
  get 'dataview/superindex_sex_graph'
  get 'dataview/superindex_age_graph'
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
  get 'dataview/haplotype_frequencies'
  get 'dataview/haplotype_frequecies_data'

  get 'profiles/show'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources 'dataview', only: [:index]

  get 'nmdp_apis/test_gfe'

end
