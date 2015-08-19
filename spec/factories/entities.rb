# == Schema Information
#
# Table name: entities
#
#  id          :integer          not null, primary key
#  folder_id   :integer
#  name        :string(255)
#  skp_file    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  description :text(65535)
#  icon        :string(255)
#  uuid        :string(255)
#  is_system   :boolean          default(FALSE)
#  visible     :boolean          default(TRUE)
#

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
