require 'rails_helper'

describe 'Usuário busca por pedido', type: :feature do
  it 'a partir do menu' do
    user = User.create!(name: 'Leandro', email: 'leandro@email.com', password: 'password')

    login_as user
    visit root_path
    within 'header nav' do
      expect(page).to have_field 'Buscar Pedido'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'e deve esta autenticado' do
    visit root_path
    within 'header nav' do
      expect(page).not_to have_field 'Buscar Pedido'
      expect(page).not_to have_button 'Buscar'
    end
  end
  it 'e encontra pedido' do
    user = User.create!(name: 'Leandro', email: 'leandro@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro',
                                  area: 60_000, address: 'Av do Porto, 1000', cep: '20000-000',
                                  description: 'Galpão do Rio')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as user
    visit root_path
    within 'header nav' do
      fill_in 'Buscar Pedido', with: order.code[1..5]
      click_on 'Buscar'
    end

    expect(page).to have_content "Resultados da Busca por: #{order.code[1..5]}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content "Galpão Destino: SDU | Rio"
    expect(page).to have_content "Fornecedor: ACME LTDA"
  end

   it 'e passa o código exato' do
    user = User.create!(name: 'Leandro', email: 'leandro@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro',
                                  area: 60_000, address: 'Av do Porto, 1000', cep: '20000-000',
                                  description: 'Galpão do Rio')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as user
    visit root_path
    within 'header nav' do
      fill_in 'Buscar Pedido', with: order.code
      click_on 'Buscar'
    end

    expect(page).to have_content "Pedido #{order.code}"
    expect(page).to have_content "Galpão Destino: SDU | Rio"
    expect(page).to have_content "Fornecedor: ACME LTDA"
  end

  it 'e encontra múltiplos pedidos' do
    user = User.create!(name: 'Leandro', email: 'leandro@email.com', password: 'password')
    first_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                        address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                        description: 'Galpão destinado para caragas internacionais')
    second_warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro',
                                        area: 60_000, address: 'Av do Porto, 1000', cep: '20000-000',
                                        description: 'Galpão do Rio')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GRU1234567')
    first_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier,
                                estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GRU6789101')
    second_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier,
                                estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('SDU0000000')
    third_order = Order.create!(user: user, warehouse: second_warehouse, supplier: supplier,
                                estimated_delivery_date: 1.day.from_now)

    login_as user
    visit root_path
    within 'header nav' do
      fill_in 'Buscar Pedido', with: 'GRU'
      click_on 'Buscar'
    end

    expect(page).to have_content "Resultados da Busca por: GRU"
    expect(page).to have_content '2 pedidos encontrados'
    expect(page).to have_content "Código: #{first_order.code}"
    expect(page).to have_content "Código: #{second_order.code}"
    expect(page).to have_content "Galpão Destino: GRU | Aeroporto SP"
    expect(page).to have_content "Fornecedor: ACME LTDA"
    expect(page).not_to have_content "#{third_order.code}"
    expect(page).not_to have_content "Galpão Destino: SDU | Rio"
  end
end

