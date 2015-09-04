Sketchup::require 'json'
Sketchup::require 'base64'

module ActionCallback
  def local_models
    Dir.glob($SKP_PATH + "/*").map do |f|
      {
        :name => File.basename(f),
        :skp_file_size => File.stat(f).size,
        :created_at_normal => File.stat(f).ctime.strftime("%m月%d日"),
        :icon => "/assets/model.jpg"
      }
    end
  end

  def register_callbacks(dialog)
    dialog.add_action_callback('logger') do |action, params|
      $logger.debug params
    end

    dialog.add_action_callback('list_local_skps') do |action, params|
      files = Dir.glob($SKP_PATH + "/*").map do |f|
        File.basename(f)
      end
      update_js_value(dialog, "skp_names", files.join(","))
    end

    dialog.add_action_callback('save_current_model') do |action, params|
      model = Sketchup.active_model
      model.save File.join($SKP_PATH, "#{model.name}.skp")
    end

    dialog.add_action_callback('current_model_name_change') do |action, params|
      $logger.debug "updating name to #{params}"
      model = Sketchup.active_model
      model.name = params
    end

    dialog.add_action_callback('remove_local_model') do |action, params|
      $logger.debug "remove model #{params}"
      FileUtils.rm_rf File.join($SKP_PATH, params)
      update_js_value(dialog, "local_models", local_models.to_json)
    end

    dialog.add_action_callback('initialization') do |action, params|
      model = Sketchup.active_model
      model_name = model.name

      # initiate current_model
      thumbnail_file_path = File.join($TMP_FILE_PATH, 'thumbnail.png')
      model.save_thumbnail(thumbnail_file_path)
      base64string = Base64.encode64(File.read(thumbnail_file_path)).gsub("\n", "")
      thumbnail_src = "data:image/png;base64,#{base64string}"
      current_model = {:name => model_name, :thumbnail_src => thumbnail_src}
      update_js_value(dialog, "current_model", current_model.to_json)

      # initiate local skps files
      update_js_value(dialog, "local_models", local_models.to_json)
    end
  end

  def update_js_value(dialog, id, new_val)
    js_command = "var dom = document.getElementById('data_transfer_channel'); var scope = angular.element(dom).scope(); scope.$apply(function() { scope.#{id} = JSON.parse('#{new_val}');});"
    $logger.debug js_command
    dialog.execute_script(js_command)
  end

  module_function :update_js_value, :register_callbacks
end


