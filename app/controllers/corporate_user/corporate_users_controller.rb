module CorporateUser
  class CorporateUsersController < ApplicationController
    before_action :set_corporate_user, only: [:show, :edit, :update, :withdrawal]

    def show
    end

    def edit
    end

    def update
      Rails.logger.debug("PARAMS: #{params.inspect}")
      if @corporate_user.update(corporate_user_params)
        flash[:notice] = "社員情報が更新されました。"
        redirect_to corporate_user_corporate_user_path(@user)
      else
        flash[:alert] = "社員情報の更新に失敗しました。"
        render :edit
      end
    end

    def withdrawal
      @corporate_user.update(is_active: false) # 退会フラグを更新
      reset_session # セッション情報を削除
      redirect_to root_path, notice: '退会処理が完了しました。'
    end

    private

    def set_corporate_user
      @corporate_user = Corporate_user.find(params[:id])
    end

    def corporate_user_params
      params.require(:corporate_user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :affiliated_store, :address, :telephone_number, :status)
    end
  end
end

