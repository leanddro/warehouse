class ProductModel < ApplicationRecord
  belongs_to :supplier

  validates :name, :weight, :width, :height, :depth, :sku, presence: true
  validates :sku, length: { is: 20 }, uniqueness: true
  validates :weight, :width, :height, :depth, comparison: { greater_than: 0 }
end
