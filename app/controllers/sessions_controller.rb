class SessionsController < ApplicationController
  def new
  end

  def create
    #form_with( ... , scope: :session, ...) とした場合でも
    #Modelのインスタンスを指定したときと同様に、 
    #params にフォームデータは代入されています。
 
    email = params[:session][:email].downcase#formwithの場合は[:session][:email]で二段階で取得。emailを小文字化
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to @user#@userのusers#showへリダイレクトする
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil#ログインで保存した session[:user_id] = @user.id を削除
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url#トップページにリダイレクトする
  end

  private

  def login(email, password)
    @user = User.find_by(email: email)#emailカラムで受け取ったemailがあるか確認
    if @user && @user.authenticate(password)#if @userでユーザーがいるか確認　後半の条件でパスワードがあっているか確認
      #ログイン成功
      session[:user_id] = @user.id#ブラウザにはcookieとして、サーバーにはsessionとしてログイン状態が維持される
      return true
    else
      #ログイン失敗
      return false
    end
  end



end
