require 'rails_helper'

describe 'Usuário informa novo status de pedido', type: :feature do
  it 'e pedido foi entregue' do
    user = User.create!(name: 'Leandro', email: 'leandro@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para caragas internacionais')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    product = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, width: 70, height: 100, depth: 75,
                                  supplier: supplier, sku: 'CAD-GAME-SUPER-RGB10')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                                estimated_delivery_date: 1.day.from_now, status: :pending)

    OrderItem.create!(order: order, product_model: product, quantity: 5)

    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como ENTREGUE'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Entregue'
    expect(page).not_to have_button 'Marcar como ENTREGUE'
    expect(page).not_to have_button 'Marcar como CANCELADO'
  end

  it 'e pedido foi cancelado' do
    user = User.create!(name: 'Leandro', email: 'leandro@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para caragas internacionais')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    product = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, width: 70, height: 100, depth: 75,
                                  supplier: supplier, sku: 'CAD-GAME-SUPER-RGB10')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                                estimated_delivery_date: 1.day.from_now, status: :pending)

    OrderItem.create!(order: order, product_model: product, quantity: 5)

    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como CANCELADO'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Cancelado'
    expect(page).not_to have_button 'Marcar como ENTREGUE'
    expect(page).not_to have_button 'Marcar como CANCELADO'
  end
end

