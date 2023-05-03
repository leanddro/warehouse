require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor', type: :feature do
  it 'a partir da tela inicial' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                    registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                    city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'

    expect(page).to have_content 'ACME LTDA'
    expect(page).to have_content 'Documento: 1880678200011'
    expect(page).to have_content 'Endereço: Av das Palmas, 100 - Bauru - SP'
    expect(page).to have_content 'E-mail: contato@acme.com'
  end

  it 'e volta para tela inicial' do
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                    registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                    city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Voltar'

    expect(page).to have_content 'Fornecedores'
  end

  it 'e vê a lista de modelos cadastrado' do
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                    registration_number: '1880678200011', full_address: 'Av das Palmas, 100',
                    city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height:45, depth: 10, sku: 'TV32-SAMSU-XPTO90-SM',
                        supplier: supplier)
    ProductModel.create!(name: 'Soundbar 7.1 Surround', weight: 3000, width: 80, height:15, depth: 20,
                        sku: 'SOU71-SAMSU-NOIZ77SD', supplier: supplier)

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'

    

  end

end

