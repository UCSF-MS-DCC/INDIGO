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

  namespace :dataview do
    get 'index'
    get 'superindex'
    get 'superindex_race_graph'
    get 'superindex_sex_graph'
    get 'superindex_age_graph'
    get 'sample_processing_status'
    get 'sample_status'
    get 'samples_index'
    get 'hla_index'
    get 'kir_index'
    get 'samples_superindex'
    get 'hla_superindex'
    get 'kir_superindex'
    get 'modal_content'
    get 'download_sample_data'
    get 'download_hla_data'
    get 'download_kir_data'
    get 'download_hla_data_superuser'
    get 'download_kir_data_superuser'
    get 'download_all_data_superuser'
    get 'download_idr'
    get 'samples_to_json'
    get 'hlas_to_json'
    get 'kirs_to_json'
    get 'single_kir_genotype_version_table'
    get 'single_kir_wip_versions_data'
    get 'superindex_samples_to_json'
    get 'superindex_hlas_to_json'
    get 'superindex_kirs_to_json'
    get 'kir_genotyping_work_in_progress'
    get 'kir_wip_data'
    get 'method_version'
    get 'method_version_data'
    get 'allele_frequencies'
    get 'allele_frequencies_data'
    get 'haplotype_frequencies'
    get 'haplotype_frequecies_data'
  end

  get 'profiles/show'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # resources 'dataview', only: [:index]

  get 'nmdp_apis/test_gfe'
  
  get '*path', to: 'error#error_404', via: :all, as: 'error'
end
