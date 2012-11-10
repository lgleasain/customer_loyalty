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

    if @merchant.valid?
      @user.create_merchant(@merchant)
      valid_merchant = true
    elsif @user.is_customer?
      @user.create_customer
      valid_customer = true
    else
      valid_merchant = false
    end

    if @user.save && (valid_merchant || valid_customer)
      redirect_to root_path, notice: "Signed up!"
    else
      render 'new'
    end
  end
end
