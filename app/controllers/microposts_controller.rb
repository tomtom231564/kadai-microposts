class MicropostsController < ApplicationController
  #MicropostsControllerの全アクションはログインが必須
  before_action :require_user_logged_in
  
  #destroyアクションの前に本当にログインユーザーの所有しているコメントかを確認します。
  #correct_userを実行することで、 (current_user) が持つ microposts 限定で検索
  before_action :correct_user, only: [:destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @pagy, @microposts = pagy(current_user.feed_microposts.order(id: :desc))
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    #correct_user メソッドで取得した @micropost を destroy しています。
    @micropost.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)#このアクションが実行されたページに戻るメソッド
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end
  
  def correct_user
    #ログインユーザ (current_user) が持つ microposts 限定で検索
    @micropost = current_user.microposts.find_by(id: params[:id])
    #見つからなかった場合、nil が代入されるので unless @micropost で nil を判定
    unless @micropost
      redirect_to root_url#見つからないときはTOPへ戻る
    end
  end
  
end
