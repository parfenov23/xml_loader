class Product < ActiveRecord::Base
  has_many :categories_products, dependent: :destroy
  validates :uuid, uniqueness: true
  has_many :categories, through: :categories_products

  def self._import(products)
    transaction do
      import([:uuid, :title, :picture, :price, :url, :available, :metadata], products, validate: false, on_duplicate_key_ignore: true, recursive: true)
    end
  end
end
