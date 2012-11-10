class UserRegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new(params[:user])
    @user.initialize_rolable_type
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to root_path, notice: "Signed up!"
    else
      render 'new'
    end
  end
end
