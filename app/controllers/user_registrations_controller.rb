class UserRegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new(params[:user])
    @user.initialize_rolable_type
    @merchant = Merchant.new
    @merchant.addresses.build
  end

  def create
    @user = User.new(params[:user])
    @merchant = Merchant.create(params[:merchant])

    if params[:merchant].present?
      @user.create_merchant(@merchant)
    else
      @user.create_customer
    end

    if @user.save
      redirect_to root_path, notice: "Signed up!"
    else
      render 'new'
    end
  end
end
