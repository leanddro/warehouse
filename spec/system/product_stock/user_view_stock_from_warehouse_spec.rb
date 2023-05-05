require 'rails_helper'

describe 'Usuário vê estoque', type: :feature do
  it 'na tela de galpão' do
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

    w = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                      description: 'Galpão destinado para caragas internacionais')

    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletrônicos LTDA',
                              registration_number: '0161465165151', full_address: 'Av Nações Unidas, 1000',
                              city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    order = Order.create!(user: user, warehouse: w, supplier: supplier,
                          estimated_delivery_date: 1.day.from_now)

    product_tv = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height:45, depth: 10,
                                    sku: 'TV32-SAMSU-XPTO90-SM', supplier: supplier)
    ProductModel.create!(name: 'Soundbar 7.1 Surround', weight: 3000, width: 80, height:15, depth: 20,
                                          sku: 'SOU71-SAMSU-NOIZ7-SM', supplier: supplier)
    product_notebook = ProductModel.create!(name: 'Notebook i5 16GB RAM', weight: 2000, width: 40, height:9, depth: 20,
                                          sku: 'NOTEI5-SAMSU-TLI9-SM', supplier: supplier)

    3.times { StockProduct.create!(order: order, warehouse: w, product_model: product_tv) }
    2.times { StockProduct.create!(order: order, warehouse: w, product_model: product_notebook) }

    login_as user
    visit root_path
    click_on 'Aeroporto SP'
    within 'section#stock_products' do
      expect(page).to have_content 'Itens em Estoque'
      expect(page).to have_content '3 x TV32-SAMSU-XPTO90-SM'
      expect(page).to have_content '2 x NOTEI5-SAMSU-TLI9-SM'
      expect(page).not_to have_content 'SOU71-SAMSU-NOIZ7-SM'
    end
  end
end

