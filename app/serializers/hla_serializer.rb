class HlaSerializer < ActiveModel::Serializer
  attributes  :indigo_id, :sample_source, :sample_source_study, :disease, :gender, :ethnicity, :age_at_sample, :age_of_onset, :race, :original_data_source

  attribute :a_1, if: :include_a?
  attribute :a_2, if: :include_a?
  attribute :b_1, if: :include_b?
  attribute :b_2, if: :include_b?
  attribute :c_1, if: :include_c?
  attribute :c_2, if: :include_c?
  attribute :dpa1_1, if: :include_dpa?
  attribute :dpa1_2, if: :include_dpa?
  attribute :dqa1_1, if: :include_dqa?
  attribute :dqa1_2, if: :include_dqa?
  attribute :drb1_1, if: :include_drb?
  attribute :drb1_2, if: :include_drb?
  attribute :dqb1_1, if: :include_dqb?
  attribute :dqb1_2, if: :include_dqb?
  attribute :dpb1_1, if: :include_dpb?
  attribute :dpb1_2, if: :include_dpb?
  attribute :drbo_1, if: :include_drbo?
  attribute :drbo_2, if: :include_drbo?
  attribute :dpb1_phase_ambiguities, if: :include_dpb?

  def include_a?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["a"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end

  def include_b?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["b"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end

  def include_c?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["c"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end

  def include_dpa?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["dpa1"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end

  def include_dqa?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["dqa1"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end

  def include_drb?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["drb1"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end

  def include_dqb?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["dqb1"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end

  def include_dpb?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["dpb1"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end

  def include_drbo?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["drbo"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end

  def a_1
    if object.hla[0]
      object.hla[0]["a_1"]
    else
      nil
    end
  end

  def a_2
    if object.hla[0]
      object.hla[0]["a_2"]
    else
      nil
    end
  end

  def b_1
    if object.hla[0]
      object.hla[0]["b_1"]
    else
      nil
    end
  end

  def b_2
    if object.hla[0]
      object.hla[0]["b_2"]
    else
      nil
    end
  end

  def c_1
    if object.hla[0]
      object.hla[0]["c_1"]
    else
      nil
    end
  end

  def c_2
    if object.hla[0]
      object.hla[0]["c_2"]
    else
      nil
    end
  end

  def dpa1_1
    if object.hla[0]
      object.hla[0]["dpa1_1"]
    else
      nil
    end
  end

  def dpa1_2
    if object.hla[0]
      object.hla[0]["dpa1_2"]
    else
      nil
    end
  end

  def dqa1_1
    if object.hla[0]
      object.hla[0]["dqa1_1"]
    else
      nil
    end
  end

  def dqa1_2
    if object.hla[0]
      object.hla[0]["dqa1_2"]
    else
      nil
    end
  end

  def drb1_1
    if object.hla[0]
      object.hla[0]["drb1_1"]
    else
      nil
    end
  end

  def drb1_2
    if object.hla[0]
      object.hla[0]["drb1_2"]
    else
      nil
    end
  end

  def dqb1_1
    if object.hla[0]
      object.hla[0]["dqb1_1"]
    else
      nil
    end
  end

  def dqb1_2
    if object.hla[0]
      object.hla[0]["dqb1_2"]
    else
      nil
    end
  end

  def dpb1_1
    if object.hla[0]
      object.hla[0]["dpb1_1"]
    else
      nil
    end
  end

  def dpb1_2
    if object.hla[0]
      object.hla[0]["dpb1_2"]
    else
      nil
    end
  end

  def drbo_1
    if object.hla[0]
      object.hla[0]["drbo_1"]
    else
      nil
    end
  end

  def drbo_2
    if object.hla[0]
      object.hla[0]["drbo_2"]
    else
      nil
    end
  end

  def dpb1_phase_ambiguities
    if object.hla[0]
      object.hla[0]["dpb1_phase_ambiguities"]
    else
      nil
    end
  end

end
