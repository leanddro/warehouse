require 'rails_helper'

describe 'Usuário se autentica', type: :feature do
  it 'com sucesso' do

    visit root_path
    within 'nav' do
      click_on 'Entrar'
    end
    click_on 'Criar conta'

    fill_in 'Nome',	with: 'João'
    fill_in 'E-mail',	with: 'joão@email.com'
    fill_in 'Senha',	with: 'password'
    fill_in 'Confirme sua senha',	with: 'password'
    click_on 'Criar conta'

    expect(page).to have_content 'Boas vidas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'joão@email.com'
    expect(page).to have_button 'Sair'

    user = User.last
    expect(user.name).to eq 'João'
  end
end

