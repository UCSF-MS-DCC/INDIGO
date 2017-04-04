json.extract! consensus_fastq, :id, :INDIGO_ID, :gene, :fastq, :created_at, :updated_at
json.url consensus_fastq_url(consensus_fastq, format: :json)