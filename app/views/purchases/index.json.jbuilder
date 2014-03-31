json.array!(@purchases) do |purchase|
  json.extract! purchase, :id, :customer, :item, :merchant, :quantity
  json.url purchase_url(purchase, format: :json)
end
