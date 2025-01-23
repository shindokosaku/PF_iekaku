class Corporate_user::SessionsController < Devise::SessionsController
  
  def restrict_access
    unless corporate_user_signed_in?
      redirect_to new_corporate_user_session_path, alert: "アクセス権限がありません。"
    end
  end
end

