FactoryGirl.define do
  factory :entity do
    name "Name"
    skp_file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'model.skp'))}
  icon { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'bigo.jpg'))}
    user_id 1
    description "description"
    folder_id 2
  end
end
