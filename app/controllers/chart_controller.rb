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
    diags = Sample.pluck(:disease).uniq
    data = []
    @samples = Sample.where(ngs_dataset:["HLA", "HLA and KIR", "HLA only"])
    diags.each do |d|
      data.push({:diagnosis => d, :hla_genotypes_available => @samples.where(disease:d).where(hla_geno: true).count, :hla_genotypes_not_available => @samples.where(disease:d).where(hla_geno: false).count})
    end
    render json: data, status: :ok
  end

  def index_panel_three_data
    diags = Sample.pluck(:disease).uniq
    data = []
    @samples = Sample.where(ngs_dataset:["HLA and KIR", "KIR only"])
    diags.each do |d|
      data.push({:diagnosis => d,:kir_genotypes_available => @samples.where(disease:d).where(kir_raw:true).where(kir_geno:true).count,
                 :raw_kir_data_untyped => @samples.where(disease:d).where(kir_raw:true).where(kir_geno:false).count,
                 :no_raw_kir_data =>   @samples.where(disease:d).where(kir_raw:false).where(kir_geno:false).count })
    end
    render json: data, status: :ok
  end
end