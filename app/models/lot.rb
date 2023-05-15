class Lot < ApplicationRecord
  belongs_to :lot_creator, class_name: "User", foreign_key: 'started_by', optional: true
  belongs_to :lot_approver, class_name: "User", foreign_key: 'approved_by', optional: true

  has_many :lot_items
  has_many :items, through: :lot_items
  validates :code, :start_date, :finish_date, :start_bid, :increase_bid, presence: true
  validate :validate_code
  enum status: { pending: 0, approved: 5 }

  before_validation :upcase_code, on: :create

  private

  def upcase_code
    self.code = self.code.upcase
  end

  def validate_code
    return if self.code.present? && self.code.match?(/^[A-Z]{3}[0-9]{6}$/)
    
    errors.add(:code, 'precisa ter 3 letras e 6 números. Ex: ABC123456')
  end
end