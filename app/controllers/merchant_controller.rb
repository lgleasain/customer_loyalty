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

  private

  def check_merchant_logged_in
    redirect_to new_user_session_path unless current_user.try(:rolable_type) == 'merchant'
  end
end
