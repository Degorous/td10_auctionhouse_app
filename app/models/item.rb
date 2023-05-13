class Item < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  validates :name, :description, :weight, :height, :depth, presence: true

  before_validation :generate_code, on: :create

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
