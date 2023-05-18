# Contas de usuários

admin_1 = User.create!(email: 'andre@leilaodogalpao.com.br', cpf: '025.703.680-67', password: 'password')
admin_2 = User.create!(email: 'joao@leilaodogalpao.com.br', cpf: '821.528.250-47', password: 'password')
user_1 = User.create!(email: 'carla@mail.com', cpf: '504.054.690-47', password: 'password')
user_2 = User.create!(email: 'bruna@mail.com', cpf: '850.373.260-28', password: 'password')

# Cadastro de itens
periferico = Category.create!(name: 'Periférico')
hardware = Category.create!(name: 'Hardware')
smartphone = Category.create!(name: 'Smartphone')

item_a = Item.create!(name: 'G-413 CARBON', description: 'Teclado Gamer', weight: '1105', width: '445',
                      height: '132', depth: '34', category: periferico)
item_b = Item.create!(name: 'G-933 Artemis', description: 'Fone Gamer', weight: '336', width: '81',
                      height: '172', depth: '182', category: periferico)
item_c = Item.create!(name: 'G-440', description: 'Mouse Gamer', weight: '229', width: '340',
                      height: '280', depth: '3', category: periferico)
item_d = Item.create!(name: 'C922 WEBCAM', description: 'Webcam para stream', weight: '162', width: '95',
                      height: '44', depth: '71', category: periferico)
item_e = Item.create!(name: 'YETI', description: 'Microfone USB', weight: '550', width: '12',
                      height: '29', depth: '12', category: periferico)
item_f = Item.create!(name: 'SSD 240G Kingston', description: 'SSD da Kingston', weight: '40', width: '70',
                      height: '7', depth: '100', category: hardware)
item_g = Item.create!(name: 'Memória Kingston Fury 8GB', description: 'Memória DDR4 Kingston', weight: '50', width: '134',
                      height: '7', depth: '34', category: hardware)
item_h = Item.create!(name: 'MSI MAG A650BN', description: 'Fonte da MSI', weight: '2060', width: '150',
                      height: '86', depth: '140', category: hardware)
item_i = Item.create!(name: 'Moto G52', description: 'Smartphone da Motorola', weight: '169', width: '74',
                      height: '160', depth: '8', category: smartphone)
item_j = Item.create!(name: 'Galaxy A23', description: 'Smartphone da Samsung', weight: '290', width: '77',
                      height: '165', depth: '8', category: smartphone)

# Criando lotes

# Lote em andamento com dois itens
lot_1 = Lot.create!(code: 'ABC123456', start_date: Date.current, finish_date: 1.day.from_now.to_date,
                    start_bid: 100, increase_bid: 10, status: 5, started_by: admin_1, finished_by: admin_2)
LotItem.create!(item: item_h, lot: lot_1)
LotItem.create!(item: item_d, lot: lot_1)

# Lote pendente sem itens
lot_2 = Lot.create!(code: 'ZSE892309', start_date: Date.current, finish_date: 1.week.from_now.to_date,
                    start_bid: 100, increase_bid: 10, status: 0, started_by: admin_1)

# Lote pendente com dois itens
lot_3 = Lot.create!(code: 'OPA140886', start_date: Date.current, finish_date: 1.week.from_now.to_date,
                    start_bid: 100, increase_bid: 10, status: 0, started_by: admin_1)
LotItem.create!(item: item_c, lot: lot_3)
LotItem.create!(item: item_i, lot: lot_3)

travel_to 1.month.ago do

  # Lote com data expirada que recebeu um lance
  lot_4 = Lot.create!(code: 'JXP357408', start_date: Date.current, finish_date: 1.week.from_now.to_date,
                      start_bid: 100, increase_bid: 10, status: 5, started_by: admin_1, finished_by: admin_2, bid: 105, bid_user_id: user_1.id)
  LotItem.create!(item: item_a, lot: lot_4)
  LotItem.create!(item: item_e, lot: lot_4)
  
  # Lote com data expirada sem lance
  lot_5 = Lot.create!(code: 'NYX923646', start_date: Date.current, finish_date: 1.week.from_now.to_date,
                      start_bid: 100, increase_bid: 10, status: 5, started_by: admin_1, finished_by: admin_2)
  LotItem.create!(item: item_b, lot: lot_5)
  LotItem.create!(item: item_f, lot: lot_5)
end