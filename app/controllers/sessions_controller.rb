class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user # session[:user_id]
      # remember user # nToken > rDigest > rToken > cookies[:user_id],[rToken]
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user # user_url > users#show > /users/id
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in? # session.delete(:user_id) > @current_user = nil
    redirect_to root_url
    # ログインしてない状態でログアウトが押されると
    # ホームにリダイレクトする
  end
end
