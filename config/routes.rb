Rails.application.routes.draw do
 
  
  devise_for :admins, path: 'admin', skip: [:passwords] ,controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :room_assignments, only: [:index, :update]
    resources :rooms, only: [:index, :show, :update] do
      resources :messages, only: [:create, :destroy]
    end
    resources :questions, only: [:index, :show, :destroy] do
      resources :question_answers, only: [:create, :edit, :update, :destroy]
    end
    resources :admins, only: [:show, :edit, :update] do
      member do
        get 'unsubscribe'
        patch 'withdrawal'
        patch 'attend'
      end 
    end 
    get 'admins/my_page', to: 'admins#show', as: :admins_my_page
    patch 'admins/information', to: 'admins#update', as: :admins_information_update
    get 'admins/information/edit', to: 'admins#edit', as: :admins_information_edit
    get '/' => 'homes#top'
  end
  
  scope module: :public do
    resources :questions, only: [:new, :index, :show, :edit, :update, :create, :destroy]
    resources :question_answers, only: [:index, :show]
    resources :rooms, only: [:create, :show] do
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
  

end
