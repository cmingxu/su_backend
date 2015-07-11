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
#

FactoryGirl.define do
  factory :material do
    name "MyString"
vendor_id 1
icon "MyString"
price "9.99"
  end

end
