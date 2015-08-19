# == Schema Information
#
# Table name: folders
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  entity_count :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#  uuid         :string(255)
#  is_system    :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :folder do
    name "MyString"
    user_id 1
  end

end
