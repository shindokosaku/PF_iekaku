module Admin
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters, if: :devise_controller?

      def new
        @corporate_user = CorporateUser.new
      end

      protected
      # 追加のパラメーターを許可
      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
        devise_parameter_sanitizer.permit(:account_update, keys: [:nickname
      ])
      devise_parameter_sanitizer.permit(:sign_up, keys: [
        :last_name, :first_name, :last_name_kana, :first_name_kana,
        :affiliated_store, :address, :telephone_number
      ])
      end
      # 新規登録後のリダイレクト先を変更
      def after_sign_up_path_for(resource)
        flash[:notice] = "社員登録が完了しました"
        admin_corporate_user_path(resource.id) 
      end
  end
end
