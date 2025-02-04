class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :description, null: false
      t.boolean :active, default: false
      t.timestamps
    end

    add_index :categories, :description, unique: true
  end
end
