json.array!(@folders) do |folder|
  json.extract! folder, :id, :name, :entity_count
  json.url folder_url(folder, format: :json)
end
