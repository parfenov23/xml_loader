class CategoriesProduct < ActiveRecord::Base
  belongs_to :category, primary_key: "uuid", foreign_key: "category_id"
  belongs_to :product
end
