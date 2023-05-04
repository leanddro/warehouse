require 'rails_helper'

describe 'Usuário e bloqueado ao tentar acessar paginas sem estar logado', type: :feature do

  it 'redirecionado ao log_in' do

    visit root_path

    expect(page).to have_content 'Entrar'
    within 'form' do
      expect(page).to have_content 'E-mail'
      expect(page).to have_content 'Senha'
    end
  end
end
