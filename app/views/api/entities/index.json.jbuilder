json.array! @entities do |entity|
  json.folder_name entity.folder.name
  json.name entity.name
  json.skp_file entity.skp_file_url
  json.skp_file_size File.size(entity.skp_file.path)
  json.skp_file_size_humanize number_to_human_size(File.size(entity.skp_file.path))
  json.created_at entity.created_at
  json.description entity.description
  json.uuid entity.uuid
end
