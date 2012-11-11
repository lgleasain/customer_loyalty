FactoryGirl.define do
  factory :merchant do
    sequence(:reward_program_name) {|n| "Cobra Rewards #{n}"}
    sequence(:earn_type) {|n| "Cobras #{n}"}
    sequence(:reward_threshold_number) {|n| n}
    sequence(:reward_descripton) {|n| "Bee Larvae #{n}"}
    addresses { create_list :address, 2 }

    after(:create) do |merchant|
      user = create :user
      user.rolable_id = merchant.id
      user.rolable_type = 'merchant'
      user.save
    end
  end
end
