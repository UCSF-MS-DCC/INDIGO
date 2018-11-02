class KirWipSerializer < ActiveModel::Serializer
  attributes :locus, :indigo_id, :genotype_versions, :genotype, :raw_data_directory, :kir_extracted_directory, :output_directory, :status

  def indigo_id
    object.sample.indigo_id
  end

  def genotype_versions
    object.versions.size > 1 ? object.versions.size -1 : object.versions.size
  end

end
