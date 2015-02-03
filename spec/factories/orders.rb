
FactoryGirl.define do
    factory :order do
        association :payment
        name "ekta"
        email {Faker::Internet.email}
        address "aascjnn"

    factory :invalid_order do
        association :payment
        name "ekta"
        email nil
        address "aascjnn"
    end
  end
end
