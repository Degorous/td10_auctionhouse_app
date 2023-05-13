class Lot < ApplicationRecord
  validates :code, :start_date, :finish_date, :start_bid, :increase_bid, presence: true
  validate :validate_code

  before_validation :upcase_code, on: :create

  private

  def upcase_code
    self.code = self.code.upcase
  end

  def validate_code
    return if self.code.present? && self.code.match?(/^[A-Z]{3}[0-9]{6}$/)
    
    errors.add(:code, 'Precisa ter 3 letrar e 6 números')
  end
end