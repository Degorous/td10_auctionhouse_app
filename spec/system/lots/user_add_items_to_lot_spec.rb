# require 'rails_helper'

# describe 'Usuário adiciona items ao lote' do
#   it 'com sucesso' do
#     category = Category.create!(name: 'Periférico')
#     admin = User.create!(email: 'andre@leilaodogalpao.com.br', cpf: '720.978.860-35', password: 'password')
#     item = Item.create!(name: 'G-413 CARBON', description: 'Teclado Gamer', weight: '1105', width: '445',
#                         height: '132', depth: '34', category: category)
#     other_item = Item.create!(name: 'G-440', description: 'Mouse Gamer', weight: '229', width: '340',
#                               height: '280', depth: '3', category: category)
#     lot = Lot.create!(code: 'ABC123456', start_date: 1.day.from_now.to_date, finish_date: 1.week.from_now.to_date, start_bid: 100, increase_bid: 10)

#     LotItem.create!

#     login_as admin
#     visit root_path
#     click_on "Lotes"
#     click_on lot.code
#     click_on 'Adicionar Item'
#     select 'G-413 CARBON', from: 'Item'
#     click_on 'Salvar'

#     expect(current_path).to eq lots_path(lote.id)
#     expect(page).to have_content 'Item adicionado com sucesso'
#   end
# end