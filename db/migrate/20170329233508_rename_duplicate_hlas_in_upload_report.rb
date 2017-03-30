class RenameDuplicateHlasInUploadReport < ActiveRecord::Migration[5.0]
  def change
    rename_column :upload_reports, :duplicate_hlas, :duplicates
  end
end
