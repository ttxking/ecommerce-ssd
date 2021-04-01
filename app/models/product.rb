class Product < ApplicationRecord
    enum status: { draft: 0, published: 1, archieved: 2 }
    
    validates :title, presence: true
    validates :description, presence: true
    validates :stock, numericality: {greater_than_or_equal_to: 0}

    has_many :product_categories, :dependent => :destroy
    has_many :categories, through: :product_categories
end
