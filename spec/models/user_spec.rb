require 'spec_helper'

describe User do
  describe "validations" do
    before :each do
      @user = FactoryGirl.build(:user)
    end

    it "requires a name" do
      @user.name = nil
      @user.should_not be_valid
    end

    it "requires an email" do
      @user.email = nil
      @user.should_not be_valid
    end

    it "requires a password" do
      @user.password = nil
      @user.should_not be_valid
    end

    it "requires a password confirmation" do
      @user.password_confirmation = nil
      @user.should_not be_valid
    end

    it "requires the same password and password confirmation" do
      @user.password = 'abcdefg'
      @user.password_confirmation = 'gfedcba'
      @user.should_not be_valid
    end
  end
end
