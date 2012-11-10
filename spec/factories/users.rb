FactoryGirl.define do
  factory :user do
    name { Forgery::Name.full_name }
    phone_number { Forgery::Address.phone }
    email { Forgery::Email.address }
    password 'abc123'
    password_confirmation 'abc123'
  end
end
