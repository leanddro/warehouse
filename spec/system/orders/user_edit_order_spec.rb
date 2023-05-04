require 'rails_helper'

describe 'usuário edita pedido', type: :feature do
  it 'e deve esta autenticado' do
    user = User.create!(name: 'Leandro', email: 'leandro@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para caragas internacionais')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                                estimated_delivery_date: 1.day.from_now)

    visit edit_order_path(order.id)

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    user = User.create!(name: 'Leandro', email: 'leandro@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para caragas internacionais')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                    registration_number: '5513528500016', full_address: 'Torre da Indústria, 1',
                    city: 'Teresina', state: 'PI', email: 'contato@spark.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                                estimated_delivery_date: 1.day.from_now)

    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'

    fill_in 'Data Prevista de Entrega',	with: 2.day.from_now
    select 'Spark Industries Brasil LTDA', from: 'Fornecedor'
    click_on 'Gravar'

    expect(page).to have_content 'Pedido atualizado com sucesso.'
    expect(page).to have_content 'Fornecedor: Spark Industries Brasil LTDA'
    formatted_date = I18n.localize(2.day.from_now.to_date)
    expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}"
  end

  it 'caso seja o responsável' do
    user = User.create!(name: 'Leandro', email: 'leandro@email.com', password: 'password')
    other_user = User.create!(name: 'Andre', email: 'andre@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para caragas internacionais')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                                estimated_delivery_date: 1.day.from_now)
    login_as other_user
    visit edit_order_path(order.id)

    expect(current_path).to eq root_path
  end

end
