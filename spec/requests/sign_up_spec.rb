require 'spec_helper'

describe "Sign Ups", js: true do
  context "Customer sign up" do
    it "can sign up successfully" do
      visit(customer_sign_up_path)
      fill_in('user[name]', with: "Bob")
      fill_in('user[email]', with: 'bob@example.com')
      fill_in('user[password]', with: 'abcd1234')
      fill_in('user[password_confirmation]', with: 'abcd1234')
      click_on("Sign up")
      page.should have_content("Signed up!")
    end
  end

  context "Merchant sign up" do
    it "can sign up successfully" do
      visit(merchant_sign_up_path)
      fill_in('user[name]', with: "Bob")
      fill_in('user[email]', with: 'bob@example.com')
      fill_in('user[password]', with: 'abcd1234')
      fill_in('user[password_confirmation]', with: 'abcd1234')
      click_on("Sign up")
      page.should have_content("Signed up!")
    end
  end
end
