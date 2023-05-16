class Lot < ApplicationRecord
  belongs_to :lot_creator, class_name: "User", foreign_key: 'started_by', optional: true
  belongs_to :lot_approver, class_name: "User", foreign_key: 'approved_by', optional: true
  belongs_to :bid_user, class_name: "User", optional: true

  has_many :lot_items
  has_many :items, through: :lot_items
  validates :code, :start_date, :finish_date, :start_bid, :increase_bid, presence: true
  validates :code, uniqueness: true
  validate :validate_code
  validate :validate_bid
  enum status: { pending: 0, approved: 5 }

  before_create :upcase_code

  private

  def upcase_code
    self.code = self.code.upcase
  end

  def validate_code
    return if self.code.present? && self.code.match?(/^[A-Z]{3}[0-9]{6}$/)
    
    errors.add(:code, 'precisa ter 3 letras e 6 números. Ex: ABC123456')
  end

  def validate_bid
    return if self.bid.nil?

    if self.attribute_in_database(:bid).nil?
      return if self.bid > self.start_bid 
      
      total = self.start_bid + 1
      errors.add(:bid, "inválido, lance mínimo R$#{total},00")
    else
      total = self.attribute_in_database(:bid) + self.increase_bid
      return if self.bid >= total
      
      errors.add(:bid, "inválido, lance mínimo R$#{total},00")
    end
  end
end