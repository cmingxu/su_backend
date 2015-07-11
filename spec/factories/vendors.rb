# == Schema Information
#
# Table name: vendors
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  tel        :string(255)
#  address    :string(255)
#  short_desc :text(65535)
#  desc       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :vendor do
    name "MyString"
tel "MyString"
address "MyString"
short_desc "MyText"
desc "MyText"
  end

end
