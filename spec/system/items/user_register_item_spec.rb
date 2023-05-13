require 'rails_helper'

describe 'Usuário cadastra item' do
  it 'não vê menu' do
    user = User.create!(email: 'andre@mail.com', cpf: '720.978.860-35', password: 'password')

    login_as(user)
    visit root_path

    expect(page).to have_content 'andre@mail.com'
    expect(page).to have_button 'Sair'
    expect(page).not_to have_content 'Cadastrar Item'
  end

  it 'a partir do menu' do
    admin = User.create!(email: 'andre@leilaodogalpao.com.br', cpf: '720.978.860-35', password: 'password')

    login_as(admin)
    visit root_path
    within 'nav' do
      click_on 'Cadastrar Item'
    end

    expect(current_path).to eq new_item_path
  end

  it 'com sucesso' do
    admin = User.create!(email: 'andre@leilaodogalpao.com.br', cpf: '720.978.860-35', password: 'password')
    category = Category.create!(name: 'Periférico')
    other_category = Category.create!(name: 'Eletrônico')
    allow(SecureRandom).to receive(:alphanumeric).and_return('0DLC3WATKO')
    
    login_as(admin)
    visit root_path
    click_on 'Cadastrar Item'
    fill_in 'Nome', with: 'G-413 Carbon'
    fill_in 'Descrição', with: 'Teclado mecânico da Logitech'
    fill_in 'Peso', with: '800'
    fill_in 'Altura', with: '5'
    fill_in 'Largura', with: '60'
    fill_in 'Profundidade', with: '12'
    select 'Periférico', from: 'Categoria'
    attach_file 'Imagem', Rails.root.join("spec/support/imgs/g-413.webp")
    click_on 'Salvar'

    expect(page).to have_content 'Item registrado com sucesso'
    expect(page).to have_content 'G-413 Carbon'
    expect(page).to have_content 'Descrição: Teclado mecânico da Logitech'
    expect(page).to have_content 'Dimensão: 5 cm x 60 cm x 12 cm'
    expect(page).to have_content 'Peso: 800 g'
    expect(page).to have_content 'Categoria: Periférico'
    expect(page).to have_css "img[src*='g-413']"
    expect(page).to have_content 'Código: 0DLC3WATKO'
  end
end