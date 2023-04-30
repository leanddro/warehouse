require 'rails_helper'

describe 'Usuário vê detalhes de um galpão', type: :feature do
  it 'e vê informações adicionais' do
    Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                    description: 'Galpão destinado para cargas internacionais')

    visit root_path
    click_on 'Aeroporto SP'

    expect(page).to have_content 'Galpão GRU'
    expect(page).to have_content 'Nome: Aeroporto SP'
    expect(page).to have_content 'Cidade: Guarulhos'
    expect(page).to have_content 'Área: 100000 m²'
    expect(page).to have_content 'Endereço: Avenida do Aeroporto, 1000 CEP: 15000-000'
    expect(page).to have_content 'Galpão destinado para cargas internacionais'
  end

  it 'e volta para tela inicial' do
    Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                      description: 'Galpão destinado para caragas internacionais')

    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

end

