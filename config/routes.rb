Rails.application.routes.draw do
  # topページ
  root 'homes#top'

  # 説明ページ
  get 'about' => 'homes#about'

  # ログイン機能
  devise_for :users, skip: :all
  devise_scope :user do
    get 'login' => 'devise/sessions#new', as: :new_user_session
    post 'login' => 'devise/sessions#create', as: :user_session
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
    get 'signup' => 'devise/registrations#new', as: :new_user_registration
    post 'signup' => 'devise/registrations#create', as: :user_registration
    # ゲストログイン
    post 'guest_login' => 'users/sessions#guest'
  end

  # マイページ
  get 'mypage' => 'users#mypage'
  # get 'mypage/edit' => 'users#edit'
  get 'mypage/alert' => 'users#alert'
  patch 'withdraw' => 'users#withdraw'

  # プロフィール
  resources :profiles, param: :code do
    collection do
      # プロフィール検索
      get 'search' => 'profiles#search'
    end
    member do
      # 公開設定
      get 'status' => 'profiles#status'
      # 自己紹介コメント
      resources :comments, except: [:new, :index, :show, :edit]
      # リンク
      resources :links, except: [:show, :edit]
      # カラーテーマ
      resource :colors, only: [:edit, :update]
      # 機能設定
      resource :function_settings, only: [:edit, :update]
      # タイムライン
      resources :posts, path: 'timeline', except: [:new, :show, :edit]
      # カレンダー
      resources :schedules, except: [:new, :edit, :update] do
        collection do
          get :completed
        end
      end
      # ギャラリー
      resources :images, path: 'gallery', except: [:show] do
        collection do
          get :list
        end
      end
      # フォームメール
      resources :inquiries, path: 'mail', except: [:edit, :update, :show] do
        collection do
          post :confirm
          post :back
        end
      end
    end
  end

end
