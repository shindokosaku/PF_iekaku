module Admin
  class SessionsController < Devise::SessionsController
  
    def new
      @corporate_user = CorporateUser.new
    end

    def restrict_access
      unless corporate_user_signed_in?
        redirect_to new_admin_session_path, alert: "アクセス権限がありません。"
      end
    end

    def create
      if corporate_user_signed_in?
        flash[:notice] = "ログインしました。"
        redirect_to admin_corporate_user_path(current_corporate_user.id)
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
end

