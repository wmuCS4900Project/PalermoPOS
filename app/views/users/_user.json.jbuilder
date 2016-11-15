json.extract! user, :id, :UserName, :Password, :Driver, :DateAdded, :IsManager, :created_at, :updated_at
json.url user_url(user, format: :json)