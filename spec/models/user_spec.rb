require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validar cpf' do
    it 'cpf inválido' do
      user = User.new(email: 'user@mail.com', password: 'password', cpf: '111.111.111-11')

      user.valid?
      result = user.errors.include?(:cpf)

      expect(result).to eq true
    end

    it 'cpf válido' do
      user = User.new(email: 'user@mail.com', password: 'password', cpf: '249.120.960-83')

      user.valid?
      result = user.errors.include?(:cpf)

      expect(result).to eq false
    end
  end
end