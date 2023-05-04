require 'rails_helper'

describe 'Usuário visita tela inicial', type: :feature do
  it 'e vê o nome do app' do
    user = User.create!(email: 'leandro@email.com', password: 'password')

    login_as user
    visit root_path

    within 'nav' do
      expect(page).to have_content 'Galpão & Estoque'
    end
  end

  it 'e vê os galpões cadastrado' do
    user = User.create!(email: 'leandro@email.com', password: 'password')
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                    address: 'Av do Porto, 1000', cep:'20000-000', description: 'Galpão do Rio')
    Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 45_000,
                    address: 'Av Atlântica, 50', cep:'50000-000', description: 'Perto do Aeroporto')

    login_as user
    visit root_path

    expect(page).to have_content 'Rio'
    expect(page).to have_content 'Código: SDU'
    expect(page).to have_content 'Cidade: Rio de Janeiro'
    expect(page).to have_content '60000 m²'

    expect(page).to have_content 'Maceio'
    expect(page).to have_content 'Código: MCZ'
    expect(page).to have_content 'Cidade: Maceio'
    expect(page).to have_content '45000 m²'
  end

  it 'e vê que não tem galpões cadastrados' do
    user = User.create!(email: 'leandro@email.com', password: 'password')

    login_as user
    visit root_path

    expect(page).to have_content 'Não existem galpões cadastrados'
  end
end


