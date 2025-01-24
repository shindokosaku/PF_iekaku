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
  end
end

