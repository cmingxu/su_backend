Sketchup::require 'json'
Sketchup::require 'base64'
Sketchup::require 'open-uri'
Sketchup::require 'net/http'

module ActionCallback
  def base64_icon(icon_path)
    return "" if icon_path == ""
    base64string = Base64.encode64(File.read(icon_path)).gsub("\n", "")
    "data:image/png;base64,#{base64string}"
  end

  def local_models
    Dir.glob($SKP_PATH + File::Separator + "*").map do |f|
      icon_path = File.join($TMP_FILE_PATH, File.basename(f).split(".")[0] + ".png")
      {
        :name => File.basename(f),
        :skp_file_size => File.stat(f).size,
        :created_at_normal => File.stat(f).ctime.strftime("%m月%d日"),
        :icon => base64_icon(File.exists?(icon_path) ? icon_path : ""),
        :path => f
      }
    end
  end

  def update_js_value(dialog, id, new_val)
    js_command = "var dom = document.getElementById('data_transfer_channel'); var scope = angular.element(dom).scope(); scope.$apply(function() { scope.#{id} = JSON.parse('#{new_val}');});"
    $logger.debug js_command
    dialog.execute_script(js_command)
  end

  def register_callbacks(dialog)
    dialog.add_action_callback('logger') do |action, params|
      $logger.debug params
    end

    dialog.add_action_callback('list_local_skps') do |action, params|
      files = Dir.glob($SKP_PATH + File::Separator + "*").map do |f|
        File.basename(f)
      end
      update_js_value(dialog, "skp_names", files.join(","))
    end

    dialog.add_action_callback('save_current_component_definition') do |action, params|
      model = Sketchup.active_model
      current_entity = model.selection.first
      if current_entity.is_a?(Sketchup::ComponentInstance) && current_entity.definition.name
        current_entity.definition.save_as File.join($SKP_PATH, "#{current_entity.definition.name}.skp")
        thumbnail_file_path = File.join($TMP_FILE_PATH, "#{current_entity.definition.name}.png")
        current_entity.definition.refresh_thumbnail
        current_entity.definition.save_thumbnail(thumbnail_file_path)

        update_js_value(dialog, "local_models", local_models.to_json)
      end
    end

    dialog.add_action_callback('current_component_definition_name_change') do |action, params|
      $logger.debug "updating name to #{params}"
      model = Sketchup.active_model
      current_entity = model.selection.first
      if current_entity.is_a?(Sketchup::ComponentInstance)
        current_entity.definition.name = params
      end
    end

    dialog.add_action_callback('replace_by_name') do |action, params|
      #$logger.debug "replace active_model by model #{params}"
      #model = Sketchup.active_model
      #path = Sketchup.find_support_file(File.join($SKP_PATH, params))
      #$logger.debug path
      #definitions = model.definitions
      #componentdefinition = definitions.load path
    end

    dialog.add_action_callback('remove_local_component_definition') do |action, params|
      $logger.debug "remove model #{params}"
      FileUtils.rm_rf File.join($SKP_PATH, params)
      update_js_value(dialog, "local_models", local_models.to_json)
    end

    dialog.add_action_callback('upload_local_model') do |action, params|
      $logger.debug "upload model #{params}"
      $logger.debug "model name #{params.split("||")[0]}"
      $logger.debug "cookies name #{params.split("||")[1]}"

      model_name = params.split("||")[0]
      auth_token = params.split("||")[1]

      uri = URI(BuildingUI::HOST + "/api/entities")
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json', 'Auth-Token' => auth_token})
      req.body = {entity: { name: model_name, file_content: Base64.encode64(File.read(File.join($SKP_PATH, model_name)))  }}.to_json
      res = http.request(req)
      puts "response #{res.body}"
    end

    dialog.add_action_callback('initialization') do |action, params|
      model = Sketchup.active_model
      selection = model.selection.first
      current_entity = {}
      case selection
      when NilClass
      when Sketchup::Edge
        current_entity = {:name => "Edge", :thumbnail_src => 'thumbnail.png', :type => "edge"}
      when Sketchup::ComponentInstance
        component_definition  = selection.definition
        dynamic_attributes = selection.attribute_dictionary("dynamic_attributes")
        component_definition_name = dynamic_attributes["_name"] if dynamic_attributes
        thumbnail_file_path = File.join($TMP_FILE_PATH, 'thumbnail.png')
        component_definition.refresh_thumbnail
        component_definition.save_thumbnail(thumbnail_file_path)
        base64string = Base64.encode64(File.read(thumbnail_file_path)).gsub("\n", "")
        thumbnail_src = "data:image/png;base64,#{base64string}"
        current_entity = {:name => component_definition_name || component_definition.name, :thumbnail_src => thumbnail_src, :type => "component_definition"}
      when Sketchup::Group
      when Sketchup::Face
      end

      # initiate current_model
      update_js_value(dialog, "current_entity", current_entity.to_json)

      # initiate local skps files
      update_js_value(dialog, "local_models", local_models.to_json)
    end

    dialog.add_action_callback('list_attribute_dictionaries') do |action, params|
      model = Sketchup.active_model
      current_entity = model.selection.first
      if current_entity
        current_entity.attribute_dictionaries.each do |dict|
          $logger.debug "1111111111 #{dict.name}"
          dict.each_pair do |k, v|
            $logger.debug "#{k} => #{v}"
          end
        end
      end

      current_entity.definition.entities.each do |sub_compo_def|
        sub_compo_def.attribute_dictionaries.each do |dict|
          $logger.debug "xxxxx1111111111 #{dict.name}"
          dict.each_pair do |k, v|
            $logger.debug "xxxxxxx   #{k} => #{v}"
          end
        end
      end
    end

    dialog.add_action_callback('insert_component_definition') do |action, params|
      #point = Geom::Point3d.new 10,20,30
      #transform = Geom::Transformation.new point
      #model = Sketchup.active_model
      #entities = model.active_entities
      #path = Sketchup.find_support_file "Bed.skp",
      #"Components/Components Sampler/"
      #definitions = model.definitions
      #componentdefinition = definitions.load path
      #instance = entities.add_instance componentdefinition, transform
      #point = componentdefinition.insertion_point
    end

    dialog.add_action_callback('download_from_system') do |action, params|
      skp_file_path = params.split('|')[0]
      f = File.open(File.join($SKP_PATH, "s_#{File.basename(skp_file_path)}"), "w")
      f << open(BuildingUI::HOST + skp_file_path).read
      f.close

      icon_file_path = params.split('|')[1]
      f = File.open(File.join($TMP_FILE_PATH, "s_#{File.basename(icon_file_path)}"), "w")
      f << open(BuildingUI::HOST + icon_file_path).read
      f.close

      update_js_value(dialog, "local_models", local_models.to_json)
    end
  end


  module_function :update_js_value, :register_callbacks, :local_models, :base64_icon
end


