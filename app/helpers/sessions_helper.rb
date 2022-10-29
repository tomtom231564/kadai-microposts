module SessionsHelper
  def current_user#def current_user は、現在ログインしているユーザを取得するメソッド
    ##User.find_by(...) からログインユーザを取得して@current_userに代入する（インスタンスを作成する）
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?#ログインしていればtrueを返す関数
    !!current_user#current_user関数を使ってすでにログインしていたら、ユーザーを返す。！はnot（演算子）なので、!!でtrueになる。
  end
end
