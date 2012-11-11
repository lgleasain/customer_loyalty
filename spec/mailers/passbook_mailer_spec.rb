require "spec_helper"

describe PassbookMailer do
  describe "send passbook" do
    let(:customer) { FactoryGirl.create(:customer) }
    let(:merchant) { FactoryGirl.create(:merchant) }
    let(:passbook) { Passbook::MerchantPassbook.new customer.id, merchant.id }
    let(:mail) { PassbookMailer.send_passbook(customer, merchant, passbook) }

    before do
      passbook.stubs(:stream).returns("stuff")
    end

    it "renders the subject" do
      mail.subject.should == "#{merchant.name} passbook"
    end

    it "renders the receiver email" do
      mail.to.should == [customer.email]
    end
  end
end
