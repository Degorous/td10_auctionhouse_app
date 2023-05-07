require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    User.create!(email: 'andre@mail.com', cpf: '578.799.910-00', password: 'password')

    visit root_path
    click_on 'Entrar'
    within 'form' do
      fill_in 'E-mail', with: 'andre@mail.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso'
    within 'nav' do
      expect(page).not_to have_content 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'andre@mail.com'
    end    
  end

  it 'e faz logout' do
    User.create!(email: 'andre@mail.com', cpf: '578.799.910-00', password: 'password')

    visit root_path
    click_on 'Entrar'
    within 'form' do
      fill_in 'E-mail', with: 'andre@mail.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_content 'Sair'
    expect(page).not_to have_content 'andre@mail.com'
  end
end