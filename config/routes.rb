Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'#←TOPページはroot toを使って作成
  
  get 'login', to: 'sessions#new'#loginページを作る。コントローラー名はsesson.あとでコントローラーを作る
  post 'login', to: 'sessions#create'#loginページを作る。コントローラー名はsesson.あとでコントローラーを作る
  delete 'logout', to: 'sessions#destroy'
  
  
  get 'signup', to: 'users#new'#登録ページをデフォルトのusers/newではなくusers/signupにかえる
  resources :users, only: [:index, :show, :create]#←必要な動作に絞っている。newは違うページ名にしてつくったので作成しない
  resources :microposts, only: [:create, :destroy]##←必要な動作に絞っている。
end
