# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Dir[ Rails.root.join('vendor','assets','*/') ].each do |dir|
  dir = Pathname.new(dir)
  Rails.application.config.assets.precompile += Dir[ dir.join('**','*') ].select{ |f| File.file?(f) }.map{ |f|                      
  Pathname.new(f).relative_path_from(dir).to_s }
end
