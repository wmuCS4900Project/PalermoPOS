json.extract! orderline, :id, :belongs_to, :ProductParentID, :Options, :ItemTotalCost, :created_at, :updated_at
json.url orderline_url(orderline, format: :json)