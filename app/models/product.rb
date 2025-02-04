class Product < ApplicationRecord
    belongs_to :category
    validates :title, presence: true
    validates :price, numericality: { greater_than: 0, presence: true }
    validates :description, presence: true
end
