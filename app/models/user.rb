class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :cpf, presence: true
  validates :cpf, uniqueness: true
  validate :validate_cpf

  before_create :admin_email

  def validate_cpf
    return if CPF.valid?(cpf)

    errors.add(:cpf, "CPF inválido")
  end

  def admin_email
    if email.include?('@leilaodogalpao.com.br')
      self.admin = true
    end
  end
end
