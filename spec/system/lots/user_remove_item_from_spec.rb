require 'rails_helper'

describe 'Usuário remove item do lote' do
  include ActionView::RecordIdentifier

  it 'com sucesso' do
    category = Category.create!(name: 'Periférico')
    admin = User.create!(email: 'andre@leilaodogalpao.com.br', cpf: '720.978.860-35', password: 'password')
    item_a = Item.create!(name: 'G-413 CARBON', description: 'Teclado Gamer', weight: '1105', width: '445',
                          height: '132', depth: '34', category: category)
    item_b = Item.create!(name: 'G-933 Artemis', description: 'Fone Gamer', weight: '336', width: '81',
                          height: '172', depth: '182', category: category)
    lot = Lot.create!(code: 'ABC123456', start_date: 1.day.from_now.to_date, finish_date: 1.week.from_now.to_date,
                      start_bid: 100, increase_bid: 10)
    LotItem.create!(item: item_a, lot: lot)
    LotItem.create!(item: item_b, lot: lot)

    login_as admin
    visit root_path
    click_on lot.code
    find_button('Remover Item', id: dom_id(item_b)).click

    expect(current_path).to eq lot_path(lot.id)
    expect(page).to have_content 'Item removido com sucesso'
    expect(page).to have_content 'G-413 CARBON'
    expect(page).not_to have_content 'G-933 Artemis'
  end
end