class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.string :parent_id
      t.string :uuid

      t.timestamps null: false
    end

    add_index :categories, [:uuid], unique: true
  end
end
