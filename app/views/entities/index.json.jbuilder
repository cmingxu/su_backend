json.array!(@entities) do |entity|
  json.extract! entity, :id, :folder_id, :name, :skp_file
  json.url entity_url(entity, format: :json)
end
