class KirSerializer < ActiveModel::Serializer
  attributes :indigo_id, :sample_source, :sample_source_study, :disease, :gender, :ethnicity, :age_at_sample, :age_of_onset, :race

  attribute :KIR2DL1, if: :include_2DL1?
  attribute :KIR2DL2, if: :include_2DL2?
  attribute :KIR2DL3, if: :include_2DL3?
  attribute :KIR2DL4, if: :include_2DL4?
  attribute :KIR2DL5A, if: :include_2DL5A?
  attribute :KIR2DL5B, if: :include_2DL5B?
  attribute :KIR2DP1, if: :include_2DP1?
  attribute :KIR2DS1, if: :include_2DS1?
  attribute :KIR2DS2, if: :include_2DS2?
  attribute :KIR2DS3, if: :include_2DS3?
  attribute :KIR2DS4, if: :include_2DS4?
  attribute :KIR2DS5, if: :include_2DS5?
  attribute :KIR3DL1, if: :include_3DL1?
  attribute :KIR3DL2, if: :include_3DL2?
  attribute :KIR3DL3, if: :include_3DL3?
  attribute :KIR3DS1, if: :include_3DS1?

  def include_2DL1?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["kir_2DL1"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end
  def include_2DL2?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["kir_2DL2"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end
  def include_2DL3?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["kir_2DL3"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end
  def include_2DL4?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["kir_2DL4"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end
  def include_2DL5A?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["kir_2DL5A"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end
  def include_2DL5B?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["kir_2DL5B"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end
  def include_2DP1?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["kir_2DP1"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end
  def include_2DS1?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["kir_2DS1"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end
  def include_2DS2?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["kir_2DS2"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end
  def include_2DS3?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["kir_2DS3"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end
  def include_2DS4?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["kir_2DS4"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end
  def include_2DS5?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["kir_2DS5"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end
  def include_3DL1?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["kir_3DL1"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end
  def include_3DL2?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["kir_3DL2"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end
  def include_3DL3?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["kir_3DL3"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end
  def include_3DS1?
    if @instance_options[:genelist].class == Hash
      return @instance_options[:genelist]["kir_3DS1"]
    elsif @instance_options[:genelist] == "all"
      return true
    else
      return false
    end
  end

  def KIR2DL1
    if object.kir
      object.kir["KIR2DL1"]
    else
      nil
    end
  end
  def KIR2DL2
    if object.kir
      object.kir["KIR2DL2"]
    else
      nil
    end
  end
  def KIR2DL3
    if object.kir
      object.kir["KIR2DL3"]
    else
      nil
    end
  end
  def KIR2DL4
    if object.kir
      object.kir["KIR2DL4"]
    else
      nil
    end
  end
  def KIR2DL5A
    if object.kir
      object.kir["KIR2DL5A"]
    else
      nil
    end
  end
  def KIR2DL5B
    if object.kir
      object.kir["KIR2DL5B"]
    else
      nil
    end
  end
  def KIR2DP1
    if object.kir
      object.kir["KIR2DP1"]
    else
      nil
    end
  end
  def KIR2DS1
    if object.kir
      object.kir["KIR2DS1"]
    else
      nil
    end
  end
  def KIR2DS2
    if object.kir
      object.kir["KIR2DS2"]
    else
      nil
    end
  end
  def KIR2DS3
    if object.kir
      object.kir["KIR2DS3"]
    else
      nil
    end
  end
  def KIR2DS4
    if object.kir
      object.kir["KIR2DS4"]
    else
      nil
    end
  end
  def KIR2DS5
    if object.kir
      object.kir["KIR2DS5"]
    else
      nil
    end
  end
  def KIR3DL1
    if object.kir
      object.kir["KIR3DL1"]
    else
      nil
    end
  end
  def KIR3DL2
    if object.kir
      object.kir["KIR3DL2"]
    else
      nil
    end
  end
  def KIR3DL3
    if object.kir
      object.kir["KIR3DL3"]
    else
      nil
    end
  end
  def KIR3DS1
    if object.kir
      object.kir["KIR3DS1"]
    else
      nil
    end
  end

end
