class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, :weight, :width, :height, :depth, :sku, presence: true
  validates :sku, length: { is: 20 }, uniqueness: true
  validates :weight, :width, :height, :depth, comparison: { greater_than: 0 }
end
