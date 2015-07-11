json.array!(@materials) do |material|
  json.extract! material, :id, :name, :vendor_id, :icon, :price
  json.url material_url(material, format: :json)
end
