# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    street { Forgery::Address.street_address }
    street_2 "Apartment #1"
    city { Forgery::Address.city }
    state { Forgery::Address.state }
    zip { Forgery::Address.zip }
  end
end
