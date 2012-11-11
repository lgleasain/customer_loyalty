class PassbookMailer < ActionMailer::Base
  default from: "passbook@localloyalty.co"

  def send_passbook(customer, merchant, passbook)
    @customer = customer
    @merchant = merchant
    attachments['pass.pkpass'] = passbook.stream
    mail(to: customer.email, subject: "#{merchant.name} passbook")
  end
end
