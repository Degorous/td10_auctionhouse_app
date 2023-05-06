require 'rails_helper'

describe 'Usuário vê página inicial' do
  it 'e vê o nome do app' do
    visit root_path

    expect(page).to have_content 'Leilão de Estoque'
    expect(page).to have_link 'Leilão de Estoque', href: root_path
  end
end