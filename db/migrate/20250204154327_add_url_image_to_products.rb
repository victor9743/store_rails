class AddUrlImageToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :url_image, :text
  end
end
