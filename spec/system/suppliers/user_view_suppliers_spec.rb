require 'rails_helper'

describe 'Usuário vê fornecedores', type: :feature do
  it 'a partir do menu' do
    user = User.create!(email: 'leandro@email.com', password: 'password')

    login_as user
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end

    expect(current_path).to eq suppliers_path
  end

  it 'com sucesso' do
    user = User.create!(email: 'leandro@email.com', password: 'password')
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME',
                    registration_number: '1286303100015', full_address: 'Av das Palmas, 100',
                    city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark',
                    registration_number: '5513528500016', full_address: 'Torre da Indústria, 1',
                    city: 'Teresina', state: 'PI', email: 'contato@spark.com')

    login_as user
    visit root_path
    click_on 'Fornecedores'


    expect(page).to have_content 'Fornecedores'
    expect(page).to have_content 'ACME'
    expect(page).to have_content 'Bauru - SP'
    expect(page).to have_content 'Spark'
    expect(page).to have_content 'Teresina - PI'
  end

  it 'exibe message quando não cadastrado' do
    user = User.create!(email: 'leandro@email.com', password: 'password')

    login_as user
    visit root_path
    click_on 'Fornecedores'

    expect(page).to have_content 'Não existem fornecedores cadastrados.'
  end

end

