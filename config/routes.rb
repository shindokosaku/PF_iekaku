Rails.application.routes.draw do
 
  
  devise_for :corporate_users, path: 'admin', controllers: {
     registrations: "admin/registrations",
     sessions: "admin/sessions",
  }

  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
  }

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :rooms, only: [:index, :show, :update, :destroy] do
      member do
        patch :enter_room  # ルームに入室するアクション
      end
      resources :messages, only: [:create, :destroy]
    end
    resources :questions, only: [:index, :show, :destroy] do
      resources :question_answers, only: [:create, :edit, :update, :destroy]
      resource :helpful_mark, only: [],module: :questions do
        post 'toggle_helpful', to: 'questions/helpful_marks#toggle'  #参考になったボタン
      end
    end
    resources :corporate_users, only: [:show, :edit, :update] do
      member do
        get 'unsubscribe'
        patch 'withdrawal'
        patch 'attend'
      end 
    end 
    get 'corporate_users/my_page', to: 'corporate_users#show', as: :corporate_users_my_page
    patch 'corporate_users/information', to: 'corporate_users#update', as: :corporate_users_information_update
    get 'corporate_users/information/edit', to: 'corporate_users#edit', as: :corporate_users_information_edit
    get '/' => 'homes#top'
  end
  
  scope module: :public do
    resources :questions, only: [:new, :index, :show, :edit, :update, :create, :destroy]do
      resource :quesitons, only: [], module: :quesitons do
        post 'toggle_helpful', to: 'questions/helpful_marks#toggle' #参考になったボタン
      end
    end
    
    resources :question_answers, only: [:index, :show]
    resources :rooms, only: [:create, :show, :destroy] do
      resources :messages, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update]do
      collection do
        get 'users/unsubscribe'
        patch 'users/withdrawal'
      end
    end
    get 'users/my_page', to: 'users#show', as: :users_my_page
    patch 'users/information', to: 'users#update', as: :users_information_update
    get 'users/information/edit', to: 'users#edit', as: :users_information_edit
  end

  root to: 'homes#top'
  get '/homes/top' => 'homes#top', as: 'top'
  get '/homes/about' => 'homes#about', as: 'about'
  get 'search' => "searches#search"
  

end
