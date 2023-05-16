require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um número de série' do
    it 'ao criar um StockProduct' do
      user = User.create!(name: 'Leandro', email: 'leandro@email.com', password: 'password')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para caragas internacionais')

      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: '4344721601124', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      product = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, width: 70, height: 100, depth: 75,
                                  supplier: supplier, sku: 'CADEIRA-GAME-RGB-LED')

      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                                estimated_delivery_date: 1.day.from_now, status: :delivered)

      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      expect(stock_product.serial_number.length).to eq 20
    end

    it 'e não é modificado' do
      user = User.create!(name: 'Leandro', email: 'leandro@email.com', password: 'password')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para caragas internacionais')
     other_warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro',
                                        area: 60_000, address: 'Av do Porto, 1000', cep: '20000-000',
                                        description: 'Galpão do Rio')

      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: '4344721601124', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      product = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, width: 70, height: 100, depth: 75,
                                  supplier: supplier, sku: 'CADEIRA-GAME-RGB-LED')

      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                                estimated_delivery_date: 1.day.from_now, status: :delivered)

      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      original_serial_number = stock_product.serial_number
      stock_product.update!(warehouse: other_warehouse)
      expect(stock_product.serial_number).to eq original_serial_number
    end
  end
end
