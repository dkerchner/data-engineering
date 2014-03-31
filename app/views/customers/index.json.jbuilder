json.array!(@customers) do |customer|
  json.extract! customer, :id, :full_name
  json.url customer_url(customer, format: :json)
end
