json.extract! product, :id, :title, :price, :category_id, :description, :created_at, :updated_at
json.url product_url(product, format: :json)
