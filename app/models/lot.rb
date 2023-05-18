class Lot < ApplicationRecord
  belongs_to :lot_creator, class_name: "User", foreign_key: 'started_by', optional: true
  belongs_to :lot_approver, class_name: "User", foreign_key: 'approved_by', optional: true
  belongs_to :bid_user, class_name: "User", optional: true

  has_many :lot_items
  has_many :items, through: :lot_items
  validates :code, :start_date, :finish_date, :start_bid, :increase_bid, presence: true
  validates :code, uniqueness: true
  validate :validate_bid, :validate_bid_date, if: :new_bid
  validate :validate_code, :validate_start_date, :validate_finish_date, on: :create

  enum status: { pending: 0, approved: 5, finished: 9, canceled: 11 }

  before_create :upcase_code

  def expired?
    self.finish_date < Date.current   
  end

  private

  def upcase_code
    self.code = self.code.upcase
  end

  def validate_code
    return if self.code.present? && self.code.match?(/^[A-Z]{3}[0-9]{6}$/)
    
    errors.add(:code, 'precisa ter 3 letras e 6 números. Ex: ABC123456')
  end

  def new_bid
    self.bid_changed?
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

  def validate_bid_date
    if self.finish_date.present? && self.finish_date <= Date.current
      errors.add(:finish_date, "ultrapassada.")      
    end
  end

  def validate_start_date
    if self.start_date.present? && self.start_date < Date.current
      errors.add(:start_date, 'deve ser uma data futura')
    end    
  end

  def validate_finish_date
    if self.finish_date.present? && self.finish_date < Date.current
      errors.add(:finish_date, 'deve ser uma data futura')
    end    
  end
end