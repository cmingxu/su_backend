namespace :plugin do
  task :package do
    plugin_path = Rails.root.join('su')
    tmp_path    = Rails.root.join('tmp')

    sh "rm -f #{plugin_path}/su.zip"
    `find #{plugin_path.to_s} -name "*.rb"`.split().each do |f|
      `./bin/Scrambler #{f}`
    end

    sh "mkdir -p #{tmp_path}/su/su_building/"
    `find #{plugin_path.to_s} -name "*.rbs"`.split().each do |f|
       sh "mv #{f} #{tmp_path}/su/#{Pathname.new(f).relative_path_from(plugin_path)}"
    end

    sh "cd #{tmp_path} && zip -r su.zip su && cd -"
    sh "mv #{tmp_path}/su.zip #{plugin_path}/"
  end

  task :direct_copy do
    su_plugin_path = "/Users/cmingxu/Library/Application\ Support/SketchUp\ 2015/SketchUp/Plugins"
    FileUtils.rm_rf su_plugin_path + "/su_building.rb"
    FileUtils.rm_rf su_plugin_path + "/su_building"

    FileUtils.copy Rails.root.join("su", "su_building.rb"), su_plugin_path + "/"
    FileUtils.cp_r Rails.root.join("su", "su_building"), su_plugin_path + "/"
  end
end
