require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    it 'name is mandatory' do
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                  registration_number: '0161465165151', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

      pm = ProductModel.new(name: '', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV40-SAMS-XPTO-SMART',
                            supplier: supplier)

      result = pm.valid?

      expect(result).to eq false
    end

    it 'weight is mandatory' do
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                  registration_number: '0161465165151', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

      pm = ProductModel.new(name: 'TV 40 polegadas', weight: '', width: 70, height: 45, depth: 10, sku: 'TV40-SAMS-XPTO-SMART',
                            supplier: supplier)

      result = pm.valid?

      expect(result).to eq false
    end

    it 'width is mandatory' do
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                  registration_number: '0161465165151', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

      pm = ProductModel.new(name: 'TV 40 polegadas', weight: 900, width: '', height: 45, depth: 10, sku: 'TV40-SAMS-XPTO-SMART',
                            supplier: supplier)

      result = pm.valid?

      expect(result).to eq false
    end

    it 'height is mandatory' do
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                  registration_number: '0161465165151', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

      pm = ProductModel.new(name: 'TV 40 polegadas', weight: 900, width: 70, height: '', depth: 10, sku: 'TV40-SAMS-XPTO-SMART',
                            supplier: supplier)

      result = pm.valid?

      expect(result).to eq false
    end

    it 'depth is mandatory' do
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                  registration_number: '0161465165151', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

      pm = ProductModel.new(name: 'TV 40 polegadas', weight: 8000, width: 70, height: 45, depth: '', sku: 'TV40-SAMS-XPTO-SMART',
                            supplier: supplier)

      result = pm.valid?

      expect(result).to eq false
    end

    it 'sku is length 20' do
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                  registration_number: '0161465165151', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

      pm = ProductModel.new(name: 'TV 40 polegadas', weight: 8000, width: 70, height: 45, depth: 10, sku: '12',
                            supplier: supplier)

      result = pm.valid?

      expect(result).to eq false
    end

    it 'weight is greater than 0' do
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                  registration_number: '0161465165151', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

      pm = ProductModel.new(name: 'TV 40 polegadas', weight: 0, width: 70, height: 45, depth: 10, sku: 'TV40-SAMS-XPTO-SMART',
                            supplier: supplier)

      result = pm.valid?

      expect(result).to eq false
    end

    it 'width is greater than 0' do
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                  registration_number: '0161465165151', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

      pm = ProductModel.new(name: 'TV 40 polegadas', weight: 900, width: 0, height: 45, depth: 10, sku: 'TV40-SAMS-XPTO-SMART',
                            supplier: supplier)

      result = pm.valid?

      expect(result).to eq false
    end

    it 'height is greater than 0' do
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                  registration_number: '0161465165151', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

      pm = ProductModel.new(name: 'TV 40 polegadas', weight: 900, width: 70, height: 0, depth: 10, sku: 'TV40-SAMS-XPTO-SMART',
                            supplier: supplier)

      result = pm.valid?

      expect(result).to eq false
    end

    it 'depth is greater than 0' do
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                  registration_number: '0161465165151', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

      pm = ProductModel.new(name: 'TV 40 polegadas', weight: 8000, width: 70, height: 45, depth: 0, sku: 'TV40-SAMS-XPTO-SMART',
                            supplier: supplier)

      result = pm.valid?

      expect(result).to eq false
    end

    it 'sku is uniqueness' do
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                                  registration_number: '0161465165151', full_address: 'Av Nações Unidas, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

      pm = ProductModel.create!(name: 'TV 40 polegadas', weight: 8000, width: 70, height: 45, depth: 100, sku: 'TV40-SAMS-XPTO-SMART',
                            supplier: supplier)

      pm = ProductModel.new(name: 'TV 40 polegadas', weight: 8000, width: 70, height: 45, depth: 100, sku: 'TV40-SAMS-XPTO-SMART',
                            supplier: supplier)
      result = pm.valid?
      expect(result).to eq false
    end
  end
end
