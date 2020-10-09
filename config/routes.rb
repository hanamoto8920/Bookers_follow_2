Rails.application.routes.draw do
  # get 'users/show'
  # get 'books/index'
  # get 'books/create'
  # get 'books/edit'
  # get 'books/show'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # ブックモデルのルーティング
  # ブックコントローラ
  resources :books, only: [:edit, :create, :index, :show, :update, :destroy]

  # # ホームのコントローラ
  root "homes#top"
  get "home/about" => "homes#index"


  # ユーザーモデルのルーティング
  # ユーザーコントローラ
  resources :users, only: [:show, :edit, :update, :index]

  # ログイン認証が成功した後、投稿画像の一覧画面が表示される
  # root 'books#index'

  # フォローのルーティング
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す

end

