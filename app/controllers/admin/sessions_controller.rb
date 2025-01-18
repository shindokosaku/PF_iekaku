class Admin::SessionsController < Devise::SessionsController
  
  def restrict_access
    unless admin_signed_in?
      redirect_to new_admin_session_path, alert: "アクセス権限がありません。"
    end
  end
end

