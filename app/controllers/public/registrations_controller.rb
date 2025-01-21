module Public
  class RegistrationsController < Devise::RegistrationsController
    #skip_before_action :authenticate_user!, only: [:new, :create]
    before_action :configure_permitted_parameters, if: :devise_controller?

    def create
      @user = User.new(user_params)
      if @user.save
        sign_in(@user) # ユーザーを自動でログイン
        redirect_to after_sign_up_path_for(@user), notice: "ユーザー登録が完了しました。"
      else
        flash.now[:alert] = "ユーザー登録に失敗しました。"
        render :new
      end
    end

    protected
    # 追加のパラメーターを許可
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
      devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
    end
    # 新規登録後のリダイレクト先を変更
    def after_sign_up_path_for(resource)
      root_path
    end
    private

    def user_params
      params.require(:user).permit(
        :nickname, :password, :email
      )
    end
  end
end
