class CustomerController < ApplicationController
  before_filter :authenticate_user!

  def track_visit
    @customer_user = User.find_by_id(params[:id])
    @customer = Customer.find_by_id(@customer_user.rolable_id)
    #@customer = Customer.find_by_id(params[:id]).user
    
    @merchant_user = User.find_by_id(current_user.id)
    @merchant = Merchant.find_by_id(@merchant_user.rolable_id)
    @passbook = CustomerPassbook.find_by_customer_id_and_merchant_id(@customer_user.rolable_id, @merchant_user.rolable_id)
  end

  def after_sign_in_path_for
    track_visit_path
  end
end
