class ProductionCompany < ApplicationRecord
  validates :name, uniqueness: true
end
