class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :cpf, presence: true
  validates :cpf, uniqueness: true
  validate :validate_cpf

  def validate_cpf
    return if CPF.valid?(cpf)

    errors.add(:cpf, "inválido")
  end
end
