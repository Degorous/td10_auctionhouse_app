require 'rails_helper'

describe 'Usuário se cadastra' do
  it 'com sucesso' do
    visit root_path
    click_on 'Entrar'
    click_on 'Cadastrar'
    fill_in 'E-mail', with: 'andre@mail.com'
    fill_in 'Cpf', with: '720.978.860-35'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar Conta'

    expect(User.last.admin).to eq false
    expect(page).to have_content 'Você realizou seu registro com sucesso'
    expect(page).to have_content 'andre@mail.com'
    expect(page).to have_button 'Sair'
  end

  it 'com dados incompletos' do
    visit root_path
    click_on 'Entrar'
    click_on 'Cadastrar'
    fill_in 'E-mail', with: ''
    fill_in 'Cpf', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirme sua senha', with: ''
    click_on 'Criar Conta'

    expect(page).to have_content 'Não foi possível salvar usuário'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
    expect(page).to have_content 'Cpf não pode ficar em branco'
  end

  it 'como admin com sucesso' do
    visit root_path
    click_on 'Entrar'
    click_on 'Cadastrar'
    fill_in 'E-mail', with: 'andre@leilaodogalpao.com.br'
    fill_in 'Cpf', with: '720.978.860-35'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar Conta'

    expect(User.last.admin).to eq true
    expect(page).to have_content 'Você realizou seu registro com sucesso'
    expect(page).to have_content 'andre@leilaodogalpao.com.br'
    expect(page).to have_button 'Sair'
  end

  it 'com cpf duplicado' do
    User.create!(email: 'andre@leilaodogalpao.com.br', cpf: '720.978.860-35', password: 'password')

    visit root_path
    click_on 'Entrar'
    click_on 'Cadastrar'
    fill_in 'E-mail', with: 'andre@mail.com'
    fill_in 'Cpf', with: '720.978.860-35'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar Conta'

    expect(page).to have_content 'Cpf já está em uso'
    expect(page).to have_content 'Não foi possível salvar usuário'    
  end
end