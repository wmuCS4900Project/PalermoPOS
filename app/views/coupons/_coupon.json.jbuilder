json.extract! coupon, :id, :Name, :Type, :DollarsOff, :PercentOff, :Requirements, :created_at, :updated_at
json.url coupon_url(coupon, format: :json)