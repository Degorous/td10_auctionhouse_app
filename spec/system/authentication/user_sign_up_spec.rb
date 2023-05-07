require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    visit root_path
    click_on 'Entrar'
    click_on 'Cadastrar'
    fill_in 'E-mail', with: 'andre@mail.com'
    fill_in 'Cpf', with: '720.978.860-35'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar Conta'

    expect(page).to have_content 'Você realizou seu registro com sucesso'
    expect(page).to have_content 'andre@mail.com'
    expect(page).to have_button 'Sair'
  end
end