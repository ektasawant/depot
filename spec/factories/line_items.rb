FactoryGirl.define do
    factory :line_item do
        association :order
        association :product
        association :cart
        quantity 1
        price 400
    end
end
