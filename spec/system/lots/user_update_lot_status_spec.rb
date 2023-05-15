require 'rails_helper'

describe 'Usuário atualiza status do lote' do
  it 'para aprovado' do
    category = Category.create!(name: 'Periférico')
    admin = User.create!(email: 'andre@leilaodogalpao.com.br', cpf: '720.978.860-35', password: 'password')
    item = Item.create!(name: 'G-413 CARBON', description: 'Teclado Gamer', weight: '1105', width: '445',
                          height: '132', depth: '34', category: category)
    lot = Lot.create!(code: 'ABC123456', start_date: 1.day.from_now.to_date, finish_date: 1.week.from_now.to_date,
                      start_bid: 100, increase_bid: 10)
    
    LotItem.create!(lot: lot, item: item)

    login_as admin
    visit root_path
    click_on lot.code
    click_on 'Marcar como APROVADO'

    expect(current_path).to eq lot_path(lot.id)
    expect(page).to have_content 'Status do Lote: Aprovado'
    expect(page).not_to have_content 'Marcar como APROVADO'
  end

  it 'e é quem criou' do
    category = Category.create!(name: 'Periférico')
    admin = User.create!(email: 'andre@leilaodogalpao.com.br', cpf: '720.978.860-35', password: 'password')
    item = Item.create!(name: 'G-413 CARBON', description: 'Teclado Gamer', weight: '1105', width: '445',
                          height: '132', depth: '34', category: category)
    lot = Lot.create!(code: 'ABC123456', start_date: 1.day.from_now.to_date, finish_date: 1.week.from_now.to_date,
                      start_bid: 100, increase_bid: 10, lot_creator: admin)
    
    LotItem.create!(lot: lot, item: item)

    login_as admin
    visit root_path
    click_on lot.code

    expect(current_path).to eq lot_path(lot.id)
    expect(page).not_to have_content 'Marcar como APROVADO'
  end

  it 'e não é quem criou' do
    category = Category.create!(name: 'Periférico')
    admin = User.create!(email: 'andre@leilaodogalpao.com.br', cpf: '720.978.860-35', password: 'password')
    admin_2 = User.create!(email: 'yan@leilaodogalpao.com.br', cpf: '566.428.620-23', password: 'password')

    item = Item.create!(name: 'G-413 CARBON', description: 'Teclado Gamer', weight: '1105', width: '445',
                          height: '132', depth: '34', category: category)
    lot = Lot.create!(code: 'ABC123456', start_date: 1.day.from_now.to_date, finish_date: 1.week.from_now.to_date,
                      start_bid: 100, increase_bid: 10, lot_creator: admin)
    
    LotItem.create!(lot: lot, item: item)

    login_as admin_2
    visit root_path
    click_on lot.code
    click_on 'Marcar como APROVADO'

    expect(current_path).to eq lot_path(lot.id)
    expect(page).to have_content 'Status do Lote: Aprovado'
    expect(page).not_to have_content 'Marcar como APROVADO'
  end
end