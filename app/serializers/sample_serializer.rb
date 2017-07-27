class SampleSerializer < ActiveModel::Serializer
  attributes  :indigo_id, :sample_source, :disease, :gender, :ethnicity, :age_at_sample, :age_of_onset, :race
end
