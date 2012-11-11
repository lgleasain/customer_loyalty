class MerchantController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_merchant_logged_in

  def rewards_program
    @merchant = Merchant.find(current_user.rolable_id)
  end

  def update_rewards_program
    merchant = Merchant.find(params[:id])
    merchant.update_attributes(params[:merchant])
    redirect_to root_path, notice: "Reward program updated!"
  end

  def loyalty_scan
    @customer_user = User.find_by_id(params[:id])
    @customer = Customer.find_by_id(@customer_user.rolable_id)
    @merchant_user = User.find_by_id(current_user.id)
    @merchant = Merchant.find_by_id(@merchant_user.rolable_id)
    @passbook = CustomerPassbook.find_by_customer_id_and_merchant_id(@customer_user.rolable_id, @merchant_user.rolable_id)
  end

  private

  def check_merchant_logged_in
    redirect_to new_user_session_path unless current_user.try(:rolable_type) == 'merchant'
  end
end
