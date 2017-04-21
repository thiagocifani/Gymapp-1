# coding: utf-8
class ImcCalculation
  attr_accessor :assessment, :client, :imcs
  def initialize(assessment)
    @assessment = assessment
    @client     = assessment.client
    @imcs       = Imc.all
  end

  def message
    if age
      imcs.find { |a| imc > a.min && imc < a.max && a.gender == gender && a.age == age }.message
    else
      imcs.find { |a| imc > a.min && imc < a.max }.message
    end
  end

  def imc
    (weight / (height ** 2)).round(2)
  end

  private

  def age
    value = Time.now.year - client.birth_date.year
    if value <= 15
      value
    else
      nil
    end
  end

  def gender
    if age.to_i <= 15
      client.gender
    else
      nil
    end
  end

  def weight
    assessment.weight
  end

  def height
    assessment.height
  end
end

