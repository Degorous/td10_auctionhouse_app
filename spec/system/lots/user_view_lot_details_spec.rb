require 'rails_helper'

describe 'Usuário vê detalhes do lote' do
  it 'e não precisa estar autenticado' do
    lot = Lot.create!(code: 'ABC123456', start_date: Date.current, finish_date: 1.week.from_now.to_date,
                      start_bid: 100, increase_bid: 10, status: 5)
                      
    visit root_path
    click_on 'Lotes'
    click_on lot.code
    
    expect(page).to have_content "Detalhes do Lote #{lot.code}"
  end

  it 'e vê informações adicionais' do
    user = User.create!(email: 'andre@mail.com', cpf: '720.978.860-35', password: 'password')
    lot = Lot.create!(code: 'ABC123456', start_date: Date.current, finish_date: 1.week.from_now.to_date,
                      start_bid: 100, increase_bid: 10, status: 5)
    
    login_as user
    visit root_path
    click_on 'Lotes'
    click_on lot.code
    
    expect(current_path).to eq lot_path(lot.id)
    expect(page).to have_content "Detalhes do Lote #{lot.code}"
    expect(page).to have_content "Data de Início: #{I18n.localize(lot.start_date)}"
    expect(page).to have_content "Data de Encerramento: #{I18n.localize(lot.finish_date)}"
    expect(page).to have_content "Lance Inicial: R$100,00"
    expect(page).to have_content "Status do Lote: #{I18n.translate("lots.#{lot.status}")}"
  end
  
  it 'e vê items do lote' do
    user = User.create!(email: 'andre@mail.com', cpf: '720.978.860-35', password: 'password')
    lot = Lot.create!(code: 'ABC123456', start_date: Date.current, finish_date: 1.week.from_now.to_date,
                      start_bid: 100, increase_bid: 10, status: 5)
    category = Category.create!(name: 'Periférico')
    item_a = Item.create!(name: 'G-413 CARBON', description: 'Teclado Gamer', weight: '1105', width: '445',
                          height: '132', depth: '34', category: category)
    item_b = Item.create!(name: 'G-440', description: 'Mouse Gamer', weight: '229', width: '340',
                          height: '280', depth: '3', category: category)
    item_c = Item.create!(name: 'G-933 Artemis', description: 'Fone Gamer', weight: '336', width: '81',
                          height: '172', depth: '182', category: category)

    LotItem.create!(lot: lot, item: item_a)
    LotItem.create!(lot: lot, item: item_c)
    
    login_as user
    visit root_path
    click_on 'Lotes'
    click_on lot.code

    expect(page).to have_content 'Itens do Lote'
    expect(page).to have_content 'G-413 CARBON'
    expect(page).to have_content 'G-933 Artemis'
    expect(page).not_to have_content 'G-440'
  end
end