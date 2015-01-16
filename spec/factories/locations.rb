# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location, class: Location do
  	name "name"
  	description "MyString"
  end
end
