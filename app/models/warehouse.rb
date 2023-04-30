class Warehouse < ApplicationRecord
  validates :name, :description, :code, :address, :city, :cep, :area, presence: true
  validates :code, uniqueness: true
  validate :cep_is_valid_format


  def full_description
    "#{code} | #{name}"
  end

  private

  def cep_is_valid_format
    if !(/^[0-9]{5}-[0-9]{3}$/.match?(self.cep))
      self.errors.add(:cep, 'deve esta no formato correto')
    end
  end
end
