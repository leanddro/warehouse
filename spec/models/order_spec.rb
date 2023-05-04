require 'rails_helper'

RSpec.describe Order, type: :model do
   describe '#valid?' do
    it 'deve ter um código' do
      user = User.create!(name: 'Leandro', email: 'leandro@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro',
                      area: 60_000, address: 'Av do Porto, 1000', cep: '20000-000',
                      description: 'Galpão do Rio')
      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2023-10-01')

      result = order.valid?

      expect(result).to be true
    end

    it 'data estimada de entrada deve ser obrigatória' do
      order = Order.new(estimated_delivery_date: '')

      order.valid?

      expect(order.errors.include? :estimated_delivery_date).to be true
    end

    it 'data estimada de entrega não dever ser no passado' do
      order = Order.new(estimated_delivery_date: 1.day.ago)

      order.valid?

      expect(order.errors.include? :estimated_delivery_date).to be true
      expect(order.errors[:estimated_delivery_date]).to include ' deve ser futura.'
    end

    it 'data estimada de entrega não dever ser igual a hoje' do
      order = Order.new(estimated_delivery_date: Date.today)

      order.valid?

      expect(order.errors.include? :estimated_delivery_date).to be true
      expect(order.errors[:estimated_delivery_date]).to include ' deve ser futura.'
    end
    it 'data estimada de entrega não dever ser maior ou igual a amanhã' do
      order = Order.new(estimated_delivery_date: 1.day.from_now)

      order.valid?

      expect(order.errors.include? :estimated_delivery_date).to be false
    end
  end

  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      user = User.create!(name: 'Leandro', email: 'leandro@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro',
                      area: 60_000, address: 'Av do Porto, 1000', cep: '20000-000',
                      description: 'Galpão do Rio')
      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

      order.save!
      result = order.code

      expect(result).not_to be_empty
      expect(result.length).to eq 10
    end

    it 'E o código e único' do
      user = User.create!(name: 'Leandro', email: 'leandro@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro',
                      area: 60_000, address: 'Av do Porto, 1000', cep: '20000-000',
                      description: 'Galpão do Rio')
      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
      second_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 10.day.from_now)

      second_order.save!

      expect(second_order.code).not_to eq first_order.code
    end

    it 'e não deve ser modificado' do
      user = User.create!(name: 'Leandro', email: 'leandro@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro',
                      area: 60_000, address: 'Av do Porto, 1000', cep: '20000-000',
                      description: 'Galpão do Rio')
      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)

      original_code = order.code

      order.update!(estimated_delivery_date: 1.month.from_now)

      expect(order.code).to eq original_code

    end
  end
end
