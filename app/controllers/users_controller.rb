class UsersController < ApplicationController
  #before_action では only: で指定されたアクションに対して、事前処理
  
  before_action :require_user_logged_in, only: [:index, :show,:followings, :followers,:likes]
  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 25)#←ページネーション適応最大1ページに25件。User.order(id: :desc)はIDの降順にユーザー一覧を取得
  end

  def show
    @user = User.find(params[:id])#User、モデルのIDをみつける
     @pagy, @microposts = pagy(@user.microposts.order(id: :desc))
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def followings
    @user = User.find(params[:id])
    @pagy, @followings = pagy(@user.followings)
    counts(@user)
  end

  def followers
    @user = User.find(params[:id])
    @pagy, @followers = pagy(@user.followers)
    counts(@user)
  end
  
  def followings
    @user = User.find(params[:id])
    @pagy, @followings = pagy(@user.followings)
    counts(@user)
  end

  def followers
    @user = User.find(params[:id])
    @pagy, @followers = pagy(@user.followers)
    counts(@user)
  end
  
  def likes#likesのページ作成
    @user = User.find(params[:id])
    @pagy, @micropost = pagy(@user.likings)
    counts(@user)
   
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)#password_confirmation は password の確認のために使
  end
  
  
  
end
