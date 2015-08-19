# == Schema Information
#
# Table name: materials
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  vendor_id  :integer
#  icon       :string(255)
#  price      :decimal(10, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  uuid       :string(255)
#  code       :string(255)
#

FactoryGirl.define do
  factory :material do
    name "MyString"
vendor_id 1
price "9.99"
 sequence(:code, 1000) {|n| "fs#{n}" }
  icon { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'bigo.jpg'))}
  end


end
