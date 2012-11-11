FactoryGirl.define do
  factory :customer do
    after(:create) do |customer|
      user = create :user
      user.rolable_id = customer.id
      user.rolable_type = 'customer'
      user.save
    end
  end
end
