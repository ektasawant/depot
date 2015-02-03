FactoryGirl.define do
  factory :product do
    title  { Faker::Name.name }
    description "Having 2 GB RAM,Dual processor"
    image_url "cc.png"
    price 1
    locale "en"

  factory :invalid_product do
    title  nil
    description "Having 2 GB RAM,Dual processor"
    image_url "cc.png"
    price 1
    locale "en"
  end
end
end
