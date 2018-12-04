class ChartController < ApplicationController
  def index
    if !current_user
      redirect_to root_path
    end
  end
  def index_panel_one_data
    diags = Sample.pluck(:disease).uniq
    data = {}
    diags.each do |d|
      data[d] = Sample.where(disease:d).count
    end
    render json: data, status: :ok
  end

  def index_panel_two_data
    diags = ["PD", "MG", "NMO", "ALS"]
    data = []
    @samples = Sample.where(ngs_dataset:["HLA", "HLA and KIR", "HLA only"]).where.not(disease:["Unknown", "Not MS - Unaffected - Related", "Not MS - unaffected - related"])
    diags.each do |d|
      data.push({:diagnosis => d, :HLA_genotypes_available => @samples.where(disease:d).where(hla_geno: true).count, :samples_sent_to_sequencing_lab => @samples.where(disease:d).where(hla_geno: false).count})
    end
    # MS patients and controls have multiple values for diagnosis, making special query necessary
    data.push({:diagnosis => "MS", :HLA_genotypes_available => @samples.where(disease:["MS", "MS - Confirmed", "MS - reported"]).where(hla_geno: true).count,
              :samples_sent_to_sequencing_lab => @samples.where(disease:["MS", "MS - Confirmed", "MS - reported"]).where(hla_geno: false).count})
    data.push({:diagnosis => "Control", :HLA_genotypes_available => @samples.where(disease:["HC", "Not MS - Unaffected - Unrelated - Spouse", "Not MS"]).where(hla_geno: true).count,
              :samples_sent_to_sequencing_lab => @samples.where(disease:["HC", "Not MS - Unaffected - Unrelated - Spouse", "Not MS"]).where(hla_geno: true).count})
    render json: data, status: :ok
  end

  def index_panel_three_data
    diags = ["PD", "MG", "ALS"]
    data = []
    @samples = Sample.where(ngs_dataset:["HLA and KIR", "KIR only"]).where.not(disease:["Unknown", "Not MS - Unaffected - Related", "Not MS - unaffected - related"])
    diags.each do |d|
      data.push({:diagnosis => d,:KIR_genotypes_available => @samples.where(disease:d).where(kir_raw:true).where(kir_geno:true).count,
                 :KIR_raw_sequences_to_be_genotyped => @samples.where(disease:d).where(kir_raw:true).where(kir_geno:false).count,
                 :samples_sent_to_sequencing_lab =>   @samples.where(disease:d).where(kir_raw:false).where(kir_geno:false).count })
    end
    # MS patients and controls have multiple values for diagnosis, making special query necessary
    data.push({:diagnosis => "MS",:KIR_genotypes_available => @samples.where(disease:["MS", "MS - Confirmed", "MS - reported"]).where(kir_raw:true).where(kir_geno:true).count,
               :KIR_raw_sequences_to_be_genotyped => @samples.where(disease:["MS", "MS - Confirmed", "MS - reported"]).where(kir_raw:true).where(kir_geno:false).count,
               :samples_sent_to_sequencing_lab =>   @samples.where(disease:["MS", "MS - Confirmed", "MS - reported"]).where(kir_raw:false).where(kir_geno:false).count })
    data.push({:diagnosis => "Control",:KIR_genotypes_available => @samples.where(disease:["HC", "Not MS - Unaffected - Unrelated - Spouse", "Not MS"]).where(kir_raw:true).where(kir_geno:true).count,
               :KIR_raw_sequences_to_be_genotyped => @samples.where(disease:["HC", "Not MS - Unaffected - Unrelated - Spouse", "Not MS"]).where(kir_raw:true).where(kir_geno:false).count,
               :samples_sent_to_sequencing_lab =>   @samples.where(disease:["HC", "Not MS - Unaffected - Unrelated - Spouse", "Not MS"]).where(kir_raw:false).where(kir_geno:false).count })
    render json: data, status: :ok
  end

  def index_panel_four_data
    loci = []
    data = {}
    Kir.column_names.each do |colname|
      if colname.match(/^KIR/)
        loci.push(colname)
      end
    end
    loci.each do |locus|
      data[locus.split("R")[1]] = Kir.where.not(locus.to_sym => nil).count
    end

    render json: data, status: :ok
  end
end