module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  # ユーザーを永続的セッションに記憶する
  def remember(user)
    user.remember    # newToken > remember_digest > remember_token
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    # セッションにユーザーIDが保存されているか確認する
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)

    # クッキーに署名付きでユーザーIDが保存されているか確認する
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
     # User Model Classで定義したauthenticated? methodで
     # cookiesに保存した:remember_tokenを取り出して照合する
      if user && user.authenticated?(cookies[:remember_token])
       # 照合が完了したらlog_inメソッドを呼び出して、sessionにuserIdを登録する
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  # sessions_helperのlog_outメソッドによって呼び出される
  def forget(user)
    # User Model Classで定義したforgetメソッドを呼び出して
    # User tableのremember_digestの中身をnilにする
    user.forget
    # cookiesの中身をからにする
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザーをログアウトする
  def log_out
    # まず永続クッキーを破棄する
    # current_user methodを呼び出し、ユーザーオブジェクトを取得する
    # そのユーザーをforget methodに引数として渡して、user.forgetを呼び出す
    forget(current_user)
    # sessionの中身を空にする
    session.delete(:user_id)
    @current_user = nil
  end
end
