Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'#←TOPページはroot toを使って作成
  get 'signup', to: 'users#new'#登録ページをデフォルトのusers/newではなくusers/signupにかえる
  resources :users, only: [:index, :show, :create]#←必要な動作に絞っている。newは違うページ名にしてつくったので作成しない
end
