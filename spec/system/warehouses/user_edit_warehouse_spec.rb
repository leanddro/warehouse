require 'rails_helper'

describe 'Usuário edita um galpão', type: :feature do
  it 'a partir da página de detalhe' do
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro',
                      area: 60_000, address: 'Av do Porto, 1000', cep: '20000-000',
                      description: 'Galpão do Rio')

    visit root_path
    click_on 'Rio'
    click_on 'Editar'

    expect(page).to have_content 'Editar Galpão'

    expect(page).to have_field 'Nome', with: 'Rio'
    expect(page).to have_field 'Descrição', with: 'Galpão do Rio'
    expect(page).to have_field 'Código', with: 'SDU'
    expect(page).to have_field 'Endereço', with: 'Av do Porto, 1000'
    expect(page).to have_field 'Cidade', with: 'Rio de Janeiro'
    expect(page).to have_field 'CEP', with: '20000-000'
    expect(page).to have_field 'Área', with: 60_000
  end
  it 'com sucesso' do
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro',
                      area: 60_000, address: 'Av do Porto, 1000', cep: '20000-000',
                      description: 'Galpão do Rio')

    visit root_path
    click_on 'Rio'
    click_on 'Editar'

    fill_in 'Nome',	with: 'Galpão Rio'
    fill_in 'Área',	with: '200000'

    click_on 'Enviar'

    expect(page).to have_content 'Galpão atualizado com sucesso'
    expect(page).to have_content 'Nome: Galpão Rio'
    expect(page).to have_content 'Área: 200000 m²'

  end
  it 'e mantém os campos obrigatórios' do
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro',
                      area: 60_000, address: 'Av do Porto, 1000', cep: '20000-000',
                      description: 'Galpão do Rio')

    visit root_path
    click_on 'Rio'
    click_on 'Editar'

    fill_in 'Nome',	with: ''
    fill_in 'Área',	with: ''

    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar o galpão'
  end

end

