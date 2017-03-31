class ConsensusFastqsController < ApplicationController
  before_action :set_consensus_fastq, only: [:show, :edit, :update, :destroy]

  respond_to :html


  def test_api
    @urlstring_to_post
    @result = HTTParty.post("http://sandypoint.ucsf.edu:8080/gfe",
                            :body => {
                                       :locus => 'HLA-A',
                                       :sequence => 'tacgtacg'
                            }.to_json,
                            :headers => { 'Content-Type' => 'application/json' } )

  puts @result
  end



  def index
    @consensus_fastqs = ConsensusFastq.all
    respond_with(@consensus_fastqs)
  end

  def show
    respond_with(@consensus_fastq)
  end

  def new
    @consensus_fastq = ConsensusFastq.new
    respond_with(@consensus_fastq)
  end

  def edit
  end

  def create
    @consensus_fastq = ConsensusFastq.new(consensus_fastq_params)
    @consensus_fastq.save
    respond_with(@consensus_fastq)
  end

  def update
    @consensus_fastq.update(consensus_fastq_params)
    respond_with(@consensus_fastq)
  end

  def destroy
    @consensus_fastq.destroy
    respond_with(@consensus_fastq)
  end

  private
    def set_consensus_fastq
      @consensus_fastq = ConsensusFastq.find(params[:id])
    end

    def consensus_fastq_params
      params.require(:consensus_fastq).permit(:INDIGO_ID, :gene, :fastq)
    end
end
