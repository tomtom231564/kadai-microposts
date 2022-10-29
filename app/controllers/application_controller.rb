class ApplicationController < ActionController::Base
 include SessionsHelper  #追記
  include Pagy::Backend
  
  private

  def require_user_logged_in
    unless logged_in?#unlessはifの逆。falseの時に処理
      redirect_to login_url
    end
  end
  def counts(user)
    @count_microposts = user.microposts.count
  end
  
end
