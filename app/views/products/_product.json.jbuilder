json.extract! product, :id, :ProductName, :Cost, :ProductCategory, :Generic, :created_at, :updated_at
json.url product_url(product, format: :json)