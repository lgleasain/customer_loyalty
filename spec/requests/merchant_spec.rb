require 'spec_helper'

describe "Merchant requests", js: true do
  login_merchant

  it "can update the rewards program" do
    merchant = FactoryGirl.create(:merchant)
    visit(reward_program_details_path(merchant.id))
    fill_in('merchant[reward_program_name]', with: 'Awesomeo')
    fill_in('merchant[reward_threshold_number]', with: '5')
    fill_in('merchant[reward_description]', with: 'Free beer!')
    click_on("Update Merchant")
    page.should have_content("Reward program updated!")
  end
end
