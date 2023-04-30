require 'rails_helper'

describe 'Usuário edita um fornecedor', type: :feature do
  it 'a partir da página de detalhe' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                    registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                    city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'

    expect(page).to have_content 'Editar Fornecedor'

    expect(page).to have_field 'Nome Fantasia',	with: 'ACME'
    expect(page).to have_field 'Razão Social',	with: 'ACME LTDA'
    expect(page).to have_field 'CNPJ',	with: '1880678200011'
    expect(page).to have_field 'Endereço',	with: 'Av das Palmas, 100'
    expect(page).to have_field 'Cidade',	with: 'Bauru'
    expect(page).to have_field 'Estado',	with: 'SP'
    expect(page).to have_field 'E-mail',	with: 'contato@acme.com'
  end
  it 'com sucesso' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                    registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                    city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'

    fill_in 'CNPJ',	with: '1880678200011'
    fill_in 'E-mail',	with: 'contato@acme.com.br'

    click_on 'Enviar'

    expect(page).to have_content 'Fornecedor atualizado com sucesso'
    expect(page).to have_content 'Documento: 1880678200011'
    expect(page).to have_content 'E-mail: contato@acme.com.br'

  end
  it 'e mantém os campos obrigatórios' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                    registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                    city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'

    fill_in 'CNPJ',	with: ''
    fill_in 'E-mail',	with: ''

    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar o fornecedor'
  end

end

