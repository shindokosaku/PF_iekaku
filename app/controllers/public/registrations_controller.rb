module Public
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    # 追加のパラメーターを許可
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
      devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
    end
    # 新規登録後のリダイレクト先を変更
    def after_sign_up_path_for(resource)
      users_my_page_path # マイページへのルート名をここに記述
    end
  end
end
