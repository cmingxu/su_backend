json.array!(@vendors) do |vendor|
  json.extract! vendor, :id, :name, :tel, :address, :short_desc, :desc
  json.url vendor_url(vendor, format: :json)
end
