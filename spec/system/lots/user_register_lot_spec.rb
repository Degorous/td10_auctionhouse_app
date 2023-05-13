require 'rails_helper'

describe 'Admin cadastra pedido' do
  it 'com sucesso' do
    admin = User.create!(email: 'andre@leilaodogalpao.com.br', cpf: '720.978.860-35', password: 'password')

    login_as admin
    visit root_path
    within 'nav' do
      click_on 'Cadastrar Lote'
    end
    
    expect(current_path).to eq new_lot_path
    expect(page).to have_content 'Cadastrar novo Lote'
    expect(page).to have_content 'Código:'
    expect(page).to have_content 'Data de Início:'
    expect(page).to have_content 'Data de Fim:'
    expect(page).to have_content 'Lance Inicial:'
    expect(page).to have_content 'Diferença entre Lances:'
  end

  it 'com sucesso' do
    admin = User.create!(email: 'andre@leilaodogalpao.com.br', cpf: '720.978.860-35', password: 'password')
    
    login_as admin
    visit root_path
    click_on 'Cadastrar Lote'    
    fill_in 'Código', with: 'ABC123456'    
    fill_in 'Data de Início', with: 1.day.from_now.to_date
    fill_in 'Data de Fim', with: 2.days.from_now.to_date
    fill_in 'Lance Inicial', with: 100
    fill_in 'Diferença entre Lances', with: 5
    click_on 'Salvar'

    expect(page).to have_content 'Lote criado com sucesso'
    expect(page).to have_content 'Detalhes do Lote ABC123456'
    expect(page).to have_content "Data de Início: #{I18n.localize(1.day.from_now.to_date)}"
    expect(page).to have_content "Data de Fim: #{I18n.localize(2.days.from_now.to_date)}"
    expect(page).to have_content "Lance Inicial: R$100,00"
  end

  it 'e deixa campos em branco' do
    admin = User.create!(email: 'andre@leilaodogalpao.com.br', cpf: '720.978.860-35', password: 'password')
    
    login_as admin
    visit root_path
    click_on 'Cadastrar Lote'    
    fill_in 'Código', with: ''    
    fill_in 'Data de Início', with: ''
    fill_in 'Data de Fim', with: ''
    fill_in 'Lance Inicial', with: ''
    fill_in 'Diferença entre Lances', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Não foi possível criar o Lote'
    expect(page).to have_content 'Código não pode ficar em branco'
    expect(page).to have_content 'Data de Início não pode ficar em branco'
    expect(page).to have_content 'Data de Fim não pode ficar em branco'
    expect(page).to have_content 'Lance Inicial não pode ficar em branco'
    expect(page).to have_content 'Diferença entre Lances não pode ficar em branco'
  end
end