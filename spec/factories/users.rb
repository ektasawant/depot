FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    password "ekta"
  end
end
