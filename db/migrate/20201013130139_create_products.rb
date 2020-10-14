class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :uuid
      t.string :title
      t.string :picture
      t.string :price
      t.string :url
      t.boolean :available
      t.jsonb :metadata, null: false, default: '{}'

      t.timestamps null: false
    end
    add_index :products, [:uuid], unique: true
  end
end
