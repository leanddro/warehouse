require 'rails_helper'

describe 'usuário adiciona itens ao pedido', type: :feature do
  it 'com sucesso' do
    user = User.create!(name: 'Andre', email: 'andre@email.com', password: 'password')


    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                        address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                        description: 'Galpão destinado para caragas internacionais')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                                estimated_delivery_date: 1.day.from_now)

    ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30,
                        supplier: supplier, sku: 'PRODUTO-A-NOVO-I2023')
    ProductModel.create!(name: 'Produto B', weight: 15, width: 10, height: 20, depth: 30,
                        supplier: supplier, sku: 'PRODUTO-B-NOVO-I2023')

    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    select 'Produto A', from: 'Produto'
    fill_in 'Quantidade',	with: '8'
    click_on 'Gravar'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso.'
    expect(page).to have_content '8 x Produto A'
  end

  it 'e não ver produtos de outro fornecedor' do
    user = User.create!(name: 'Andre', email: 'andre@email.com', password: 'password')


    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                        address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                        description: 'Galpão destinado para caragas internacionais')

    supplier_a = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    supplier_b = Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                    registration_number: '3216855600111', full_address: 'Torre da Indústria, 1',
                    city: 'Teresina', state: 'PI', email: 'contato@spark.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier_a,
                          estimated_delivery_date: 1.day.from_now)

    ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30,
                        supplier: supplier_a, sku: 'PRODUTO-A-NOVO-I2023')
    ProductModel.create!(name: 'Produto B', weight: 15, width: 10, height: 20, depth: 30,
                        supplier: supplier_b, sku: 'PRODUTO-B-NOVO-I2023')

    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B'
  end

end


