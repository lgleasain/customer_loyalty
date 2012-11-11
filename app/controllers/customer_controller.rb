class CustomerController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_client_logged_in

  def show
    @customer = Customer.find(current_user.rolable_id)
  end

  def generate_passbook
    merchant = Merchant.find(params[:merchant_id])
    customer = Customer.find(current_user.rolable_id)
    passbook = Passbook::MerchantPassbook.new customer.id, merchant.id, loyalty_scan_url(merchant.id)
    user_agent = request.env['HTTP_USER_AGENT'].downcase
    if user_agent =~ /iphone/
      send_data passbook.stream, type: 'application/vnd.apple.pkpass',
                                 disposition: 'attachment',
                                 filename: 'pass.pkpass'
    else
      PassbookMailer.send_passbook(customer, merchant, passbook)
    end
    redirect_to root_path, notice: "Passbook generated!"
  end

  private

  def check_client_logged_in
    redirect_to new_user_session_path unless current_user.try(:rolable_type) == 'customer'
  end
end
