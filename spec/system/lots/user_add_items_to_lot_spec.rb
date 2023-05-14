require 'rails_helper'

describe 'Usuário adiciona items ao lote' do
  it 'com sucesso' do
    category = Category.create!(name: 'Periférico')
    admin = User.create!(email: 'andre@leilaodogalpao.com.br', cpf: '720.978.860-35', password: 'password')
    item_a = Item.create!(name: 'G-413 CARBON', description: 'Teclado Gamer', weight: '1105', width: '445',
                          height: '132', depth: '34', category: category)
    item_b = Item.create!(name: 'G-933 Artemis', description: 'Fone Gamer', weight: '336', width: '81',
                          height: '172', depth: '182', category: category)
    lot = Lot.create!(code: 'ABC123456', start_date: 1.day.from_now.to_date, finish_date: 1.week.from_now.to_date,
                      start_bid: 100, increase_bid: 10)

    login_as admin
    visit root_path
    click_on lot.code
    click_on 'Adicionar Item'
    select 'G-413 CARBON', from: 'Item'
    click_on 'Salvar'

    expect(current_path).to eq lot_path(lot.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content 'G-413 CARBON'
  end

  it 'e não vê produtos já adicionados' do
    admin = User.create!(email: 'andre@leilaodogalpao.com.br', cpf: '720.978.860-35', password: 'password')
    lot = Lot.create!(code: 'ABC123456', start_date: 1.day.from_now.to_date, finish_date: 1.week.from_now.to_date,
                      start_bid: 100, increase_bid: 10)
    category = Category.create!(name: 'Periférico')
    item_a = Item.create!(name: 'G-413 CARBON', description: 'Teclado Gamer', weight: '1105', width: '445',
                          height: '132', depth: '34', category: category)
    item_b = Item.create!(name: 'G-440', description: 'Mouse Gamer', weight: '229', width: '340',
                          height: '280', depth: '3', category: category)

    LotItem.create!(item: item_a, lot: lot)

    login_as admin
    visit root_path
    click_on lot.code
    click_on 'Adicionar Item'

    expect(current_path).to eq new_lot_lot_item_path(lot.id)
    expect(page).not_to have_content 'G-413 CARBON'
    expect(page).to have_content 'G-440'
  end
end