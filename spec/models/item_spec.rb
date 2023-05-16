require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'generate_code' do
    it 'código válido' do
      item = Item.create()

      item.valid?
      result = item.errors.include?(:code)

      expect(result).to eq false
    end
  end

  describe '#valid?' do
    it 'nome nulo' do
      item = Item.new()

      item.valid?
      result = item.errors.include?(:name)

      expect(result).to eq true 
    end

    it 'descrição nula' do
      item = Item.new()

      item.valid?
      result = item.errors.include?(:description)

      expect(result).to eq true 
    end

    it 'altura nula' do
      item = Item.new()

      item.valid?
      result = item.errors.include?(:height)

      expect(result).to eq true 
    end

    it 'peso nulo' do
      item = Item.new()

      item.valid?
      result = item.errors.include?(:weight)

      expect(result).to eq true 
    end

    it 'profundidade nula' do
      item = Item.new()

      item.valid?
      result = item.errors.include?(:depth)

      expect(result).to eq true 
    end
  end
end