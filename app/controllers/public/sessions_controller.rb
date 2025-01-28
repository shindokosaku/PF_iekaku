class Public::SessionsController < Devise::SessionsController
    def after_sign_in_path_for(resource)
      root_path
    end
  
    def create
      if user_signed_in?
        flash[:notice] = "ログインしました。"
        redirect_to root_path
      else
        flash[:alert] = "ログインに失敗しました。"
        render :new
      end
    end

    def destroy
      reset_session
      flash[:notice] = "ログアウトしました"  
      redirect_to root_path
    end
end
