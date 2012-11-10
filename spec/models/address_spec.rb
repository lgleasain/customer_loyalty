require 'spec_helper'

describe Address do
  describe "validations" do
    before :each do
      @address = FactoryGirl.build(:address)
    end

    it "requires a street" do
      @address.street = nil
      @address.should_not be_valid
    end

    it "requires a city" do
      @address.city = nil
      @address.should_not be_nil
    end

    it "requires a state" do
      @address.state = nil
      @address.should_not be_valid
    end

    it "requires a zip code" do
      @address.zip = nil
      @address.should_not be_valid
    end
  end
end
