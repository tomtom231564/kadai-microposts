class UsersController < ApplicationController
  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 25)#←ページネーション適応最大1ページに25件。User.order(id: :desc)はIDの降順にユーザー一覧を取得
  end

  def show
    @user = User.find(params[:id])#User、モデルのIDをみつける
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

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)#password_confirmation は password の確認のために使
  end
  
end
