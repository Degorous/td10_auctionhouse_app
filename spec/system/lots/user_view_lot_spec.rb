require 'rails_helper'

describe 'Usuário vê lotes' do
  it 'em andamento' do
    lot = Lot.create!(code: 'ABC123456', start_date: Date.current, finish_date: 1.week.from_now.to_date,
                      start_bid: 100, increase_bid: 10, status: 5)
      
  visit root_path

  expect(page).to have_content lot.code  
  end

  it 'futuros' do
    lot = Lot.create!(code: 'ABC123456', start_date: 1.day.from_now.to_date, finish_date: 1.week.from_now.to_date,
                      start_bid: 100, increase_bid: 10, status: 5)
      
  visit root_path

  expect(page).to have_content lot.code
  end

  it 'ambos' do
    lot = Lot.create!(code: 'ABC123456', start_date: Date.current, finish_date: 1.week.from_now.to_date,
                      start_bid: 100, increase_bid: 10, status: 5)
    lot_2 = Lot.create!(code: 'FGH123456', start_date: 1.day.from_now.to_date, finish_date: 1.week.from_now.to_date,
                      start_bid: 100, increase_bid: 10, status: 5)
      
  visit root_path

  expect(page).to have_content lot.code
  expect(page).to have_content lot_2.code
  end
end