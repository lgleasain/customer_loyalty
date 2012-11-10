class UserRegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new(params[:user])
    @user.initialize_rolable_type
    binding.pry
  end

  def create
    @user = User.new(params[:user])
    binding.pry

    if @user.save
      @user.create_child_class
      redirect_to root_path, notice: "Signed up!"
    else
      render 'new'
    end
  end
end
