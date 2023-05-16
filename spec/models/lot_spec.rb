require 'rails_helper'

RSpec.describe Lot, type: :model do
  describe '#validate_code' do
    it 'escreve o código corretamente' do
      lot = Lot.new(code: 'ABC123456')

      lot.send(:validate_code)
      result = lot.errors.include?(:code)

      expect(result).to eq false
    end

    it 'escreve o código errado' do
      lot = Lot.new(code: 'ABC123456A')

      lot.send(:validate_code)
      result = lot.errors.include?(:code)

      expect(result).to eq true
    end

    it 'escreve o código errado #2' do
      lot = Lot.new(code: '123ABCDEF')

      lot.send(:validate_code)
      result = lot.errors.include?(:code)

      expect(result).to eq true
    end

    it 'escreve o código errado #3' do
      lot = Lot.new(code: 'AA1234567')

      lot.send(:validate_code)
      result = lot.errors.include?(:code)

      expect(result).to eq true
    end
    
    it 'escreve o código errado #4' do
      lot = Lot.new(code: 'A12345678')

      lot.send(:validate_code)
      result = lot.errors.include?(:code)

      expect(result).to eq true
    end

    it 'deixa o código em branco' do
      lot = Lot.new(code: '')

      lot.send(:validate_code)
      result = lot.errors.include?(:code)

      expect(result).to eq true
    end
  end

  describe 'code uniqueness' do
    it 'códigos diferentes' do
      Lot.create!(code: 'ABC123456', start_date: 1.day.ago.to_date, finish_date: 1.week.from_now.to_date,
                              start_bid: 100, increase_bid: 10, status: 5)
      lot = Lot.new(code: 'FGH123456', start_date: 1.day.ago.to_date, finish_date: 1.week.from_now.to_date,
                          start_bid: 100, increase_bid: 10, status: 5)

      result = lot.valid?

      expect(result).to eq true
    end

    it 'códigos iguais' do
      Lot.create!(code: 'ABC123456', start_date: 1.day.ago.to_date, finish_date: 1.week.from_now.to_date,
                  start_bid: 100, increase_bid: 10, status: 5)
      lot = Lot.new(code: 'ABC123456', start_date: 1.day.ago.to_date, finish_date: 1.week.from_now.to_date,
                    start_bid: 100, increase_bid: 10, status: 5)
      
      lot.valid?
      result = lot.errors.include?(:code)
      
      expect(lot.valid?).to eq false
      expect(result).to eq true
    end
  end
end