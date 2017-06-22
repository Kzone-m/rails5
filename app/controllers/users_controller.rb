class UsersController < ApplicationController
  # prefix:user, http:GET, url:/users/:id(.:format), C/A: users#show
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      # new_user(@user) ==> user#show | /users/:id => show.html
      redirect_to @user
    else
      render 'new'
    end
  end

  # ストロングパラメーター
  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
