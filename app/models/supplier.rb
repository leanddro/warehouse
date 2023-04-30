class Supplier < ApplicationRecord
  validates :brand_name, :corporate_name, :registration_number, :full_address, :city, :state, :email, presence: true
  validates :registration_number, uniqueness: true
  validates  :registration_number, length: { is: 13 }
end
