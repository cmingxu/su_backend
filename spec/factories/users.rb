FactoryGirl.define do
  factory :user do
    email { "#{rand 1000}@bigo.com" }
password "MyString"
  end

end
