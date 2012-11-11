class CustomerController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_client_logged_in

  def show
    @customer = Customer.find(current_user.rolable_id)
  end

  def merchant_search
    @merchants = Merchant.find_by_search_params(params[:search])
  end

  def generate_passbook
    respond_to do |format|
      format.html do
        merchant = Merchant.find(params[:merchant_id])
        customer = Customer.find(current_user.rolable_id)
        passbook = Passbook::MerchantPassbook.new customer.id, merchant.id, loyalty_scan_url(merchant.id)
        user_agent = request.env['HTTP_USER_AGENT'].downcase
        if user_agent =~ /iphone/
          send_data passbook.stream, type: 'application/vnd.apple.pkpass',
                                     disposition: 'attachment',
                                     filename: 'pass.pkpass'
        else
          PassbookMailer.send_passbook(customer, merchant, passbook).deliver
        end
        redirect_to root_path, notice: "Passbook generated!"
      end
      format.svg { render :qrcode => request.url }
    end
  end

  private

  def check_client_logged_in
    redirect_to new_user_session_path unless current_user.try(:rolable_type) == 'customer' or params[:format] == 'svg'
  end
end
