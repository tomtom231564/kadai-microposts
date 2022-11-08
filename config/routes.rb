Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'#←TOPページはroot toを使って作成
  
  get 'login', to: 'sessions#new'#loginページを作る。コントローラー名はsesson.あとでコントローラーを作る
  post 'login', to: 'sessions#create'#loginページを作る。コントローラー名はsesson.あとでコントローラーを作る
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'#登録ページをデフォルトのusers/newではなくusers/signupにかえる
 
  #onlyは必要な動作に絞っている。newは違うページ名にしてつくったので作成しない
  resources :users, only: [:index, :show, :create] do
    #中間テーブルから先にある、フォロー中のユーザとフォローされているユーザ一覧を表示するページは必要
    #menberを使うと/users/:id/followingsという感じにidが付与したURLができる
    member do
          get :followings
          get :followers
          get :likes
    end
    #URLを深堀する場合 /users/search　のようにidが含まれないURLを作成する
    #collection do
      #get :search
    #end
  end
  
  resources :microposts, only: [:create, :destroy]##←必要な動作に絞っている。
  resources :relationships, only: [:create, :destroy]#中間テーブルなのでviewはない
  resources :favorites, only: [:create, :destroy]#中間テーブルなのでviewはない
end
