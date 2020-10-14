class Product < ActiveRecord::Base
  has_many :categories_products, dependent: :destroy
  validates :uuid, uniqueness: true
  has_and_belongs_to_many :categories

   def self._import(products)
    transaction do
      import([:uuid, :title, :picture, :price, :url, :available, :metadata], products, validate: false, on_duplicate_key_ignore: true, recursive: true)
    end
  end
end
