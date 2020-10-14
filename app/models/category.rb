class Category < ActiveRecord::Base
  has_many :categories, foreign_key: "parent_id", primary_key: "uuid"
  belongs_to :category, foreign_key: "parent_id", primary_key: "uuid"

  has_many :categories_products
  has_and_belongs_to_many :products

  def self._import(categories)
    transaction do
      import([:uuid, :title, :parent_id], categories, validate: false, on_duplicate_key_ignore: true)
    end
  end
end
