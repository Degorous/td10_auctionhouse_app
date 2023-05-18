require 'rails_helper'

describe 'Usuário acessa um lote' do
  it 'e não está autenticado' do
    lot = Lot.create!(code: 'ABC123456', start_date: Date.current, finish_date: 1.week.from_now.to_date,
                      start_bid: 100, increase_bid: 10, status: 5)

    visit root_path
    click_on 'Lotes'
    click_on lot.code
    
    expect(page).not_to have_field 'Lance'
    expect(page).not_to have_button 'Confirmar'
  end

  it 'e os campos corretamente' do
    user = User.create!(email: 'ian@mail.com', cpf: '720.978.860-35', password: 'password')
    lot = Lot.create!(code: 'ABC123456', start_date: Date.current, finish_date: 1.week.from_now.to_date,
                        start_bid: 100, increase_bid: 10, status: 5)

    login_as user
    visit root_path
    click_on 'Lotes'
    click_on lot.code

    expect(page).to have_field 'Lance'
    expect(page).to have_button 'Confirmar'
  end

  it 'e faz um lance' do
    user = User.create!(email: 'ian@mail.com', cpf: '720.978.860-35', password: 'password')
    lot = Lot.create!(code: 'ABC123456', start_date: Date.current, finish_date: 1.week.from_now.to_date,
                        start_bid: 100, increase_bid: 10, status: 5)

    login_as user
    visit root_path
    click_on 'Lotes'
    click_on lot.code
    fill_in 'Lance', with: '110'
    click_on 'Confirmar'

    expect(page).to have_content 'Lance efetuado com sucesso'
    expect(page).to have_content 'Último Lance: R$110,00'
  end
end