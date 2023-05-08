require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validar nome' do
    it 'com sucesso' do
      category = Category.new(name: 'Fruta')

      category.valid?
      result = category.errors.include?(:name)

      expect(result).to eq false
    end

    it 'com atributo vazio' do
      category = Category.new(name: '')

      category.valid?
      result = category.errors.include?(:name)

      expect(result).to eq true
    end
  end
end
