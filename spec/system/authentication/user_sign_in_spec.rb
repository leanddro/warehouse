require 'rails_helper'

describe 'Usuário se autentica', type: :feature do
  it 'com sucesso' do

    User.create!(name:'Leandro', email: 'leandro@email.com', password: 'password')

    visit root_path
    click_on 'Entrar'

    within 'form' do
      fill_in 'E-mail',	with: 'leandro@email.com'
      fill_in 'Senha',	with: 'password'

      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso'
    within 'nav' do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'


      expect(page).to have_content 'Leandro <leandro@email.com>'
    end
  end
  it 'e faz logout' do
    User.create!(email: 'leandro@email.com', password: 'password')

    visit root_path
    click_on 'Entrar'

    within 'form' do
      fill_in 'E-mail',	with: 'leandro@email.com'
      fill_in 'Senha',	with: 'password'

      click_on 'Entrar'
    end

    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'leandro@email.com'
  end

end

