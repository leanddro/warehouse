require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        warehouse = Warehouse.new(name: '', code: 'RIO', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')

        result = warehouse.valid?
        expect(result).to  eq false
      end

      it 'false when code is empty' do
        warehouse = Warehouse.new(name: 'Rio', code: '', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')

        result = warehouse.valid?
        expect(result).to  eq false
      end

      it 'false when address is empty' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: '',
                                  cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')

        result = warehouse.valid?
        expect(result).to  eq false
      end
      it 'false when cep is empty' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  cep: '', city: 'Rio', area: 1000, description: 'Alguma descrição')

        result = warehouse.valid?
        expect(result).to  eq false
      end

      it 'false when city is empty' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  cep: '25000-000', city: '', area: 1000, description: 'Alguma descrição')

        result = warehouse.valid?
        expect(result).to  eq false
      end

      it 'false when area is empty' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: '', description: 'Alguma descrição')

        result = warehouse.valid?
        expect(result).to  eq false
      end

      it 'false when description is empty' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000, description: '')

        result = warehouse.valid?
        expect(result).to  eq false
      end
    end

    it 'false when cep invalid format' do
      warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  cep: '0000', city: 'Rio', area: 1000, description: 'Alguma descrição')
      expect(warehouse.valid?).to be false
    end


    it 'false when address is already in use' do
      Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
      second_warehouse = Warehouse.new(name: 'Niteroi', code: 'RIO', address: 'Avenida',
                                  cep: '35000-000', city: 'Niteroi', area: 1000, description: 'Outra descrição')

      result = second_warehouse.valid?

      expect(result).to eq false
    end
  end

  describe '#full_description' do
    it 'exibe o nome e o código' do
      w = Warehouse.new(name: 'Galpão Cuiabá', code: 'CBA')

      result = w.full_description

      expect(result).to eq 'CBA | Galpão Cuiabá'
    end
  end
end
