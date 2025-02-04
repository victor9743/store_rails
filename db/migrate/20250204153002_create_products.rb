class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.decimal :price, null: false, precision: 10, scale: 2
      t.references :category, null: false, foreign_key: { on_delete: :cascade }
      t.text :description

      t.timestamps
    end

    add_index :products, :title, unique: true
  end
end
