require 'rails_helper'

describe 'Usuário remove um galpão', type: :feature do
  it 'com sucesso' do
    user = User.create!(email: 'leandro@email.com', password: 'password')
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro',
                  area: 60_000, address: 'Av do Porto, 1000', cep: '20000-000',
                  description: 'Galpão do Rio')

    login_as user
    visit root_path
    click_on 'Rio'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Rio'
    expect(page).not_to have_content 'SDU'
  end
end
