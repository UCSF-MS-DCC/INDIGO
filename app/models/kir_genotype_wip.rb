class KirGenotypeWip < ApplicationRecord
  has_paper_trail
  belongs_to :sample

  validates_presence_of :locus
  validates_presence_of :method
  validates_presence_of :sample_id
  validates_presence_of :genotype

  before_create :update_most_recent_flag
  before_update :update_most_recent_flag

  scope :latest, -> {where(most_recent:true)}


  def update_most_recent_flag
    sample_id = self.sample.id
    locus = self.locus
    method_version = self.method_version
    latest_kwp = KirGenotypeWip.where(sample_id:sample_id).where(locus:locus).where(most_recent:true).first

    if !latest_kwp
      self.most_recent = true
    elsif method_version > latest_kwp.method_version
      self.most_recent = true
      latest_kwp.update_attributes(most_recent:false)
    else
      self.most_recent = false
    end

  end


end
