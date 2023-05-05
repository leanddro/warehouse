require 'rails_helper'

describe 'Usuário cadastrar um pedido', type: :feature do
  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Registrar Pedido'

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    user = User.create!(name: 'Leandro', email: 'leandro@email.com', password: 'password')

    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro',
                      area: 60_000, address: 'Av do Porto, 1000', cep: '20000-000',
                      description: 'Galpão do Rio')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para caragas internacionais')

    Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                    registration_number: '5513528500016', full_address: 'Torre da Indústria, 1',
                    city: 'Teresina', state: 'PI', email: 'contato@spark.com')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABCDE12345')

    login_as user

    visit root_path
    click_on 'Registrar Pedido'
    select warehouse.full_description, from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega',	with: 1.day.from_now
    click_on 'Gravar'

    expect(page).to have_content 'Pedido registrado com sucesso'
    expect(page).to have_content 'Pedido ABCDE12345'
    expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
    expect(page).to have_content 'Fornecedor: ACME LTDA'
    expect(page).to have_content 'Usuário Responsável: Leandro <leandro@email.com>'
    formatted_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}"
    expect(page).to have_content 'Situação do Pedido: Pendente'
    expect(page).not_to have_content 'RIO'
    expect(page).not_to have_content 'Spark Industries Brasil LTDA'

  end

  it 'e não informa a data de entrega' do
    user = User.create!(name: 'Leandro', email: 'leandro@email.com', password: 'password')

    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro',
                      area: 60_000, address: 'Av do Porto, 1000', cep: '20000-000',
                      description: 'Galpão do Rio')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para caragas internacionais')

    Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                    registration_number: '5513528500016', full_address: 'Torre da Indústria, 1',
                    city: 'Teresina', state: 'PI', email: 'contato@spark.com')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                                registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABCDE12345')

    login_as user

    visit root_path
    click_on 'Registrar Pedido'
    select warehouse.full_description, from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega',	with: ''
    click_on 'Gravar'

    expect(page).to have_content 'Não foi possível registra o pedido'
  end

end

