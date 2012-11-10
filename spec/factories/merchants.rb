FactoryGirl.define do
  factory :merchant do
    sequence(:name) {|n| "The Honey Badger #{n} "}
    sequence(:reward_program_name) {|n| "Cobra Rewards #{n}"}
    sequence(:earn_type) {|n| "Cobras #{n}"}
    sequence(:reward_threshold_number) {|n| n}
    sequence(:reward_descripton) {|n| "Bee Larvae #{n}"}
  end
end
