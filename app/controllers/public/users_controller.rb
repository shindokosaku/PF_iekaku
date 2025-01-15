module Public
  class UsersController < ApplicationController

    before_action :authenticate_user!
    before_action :authenticate_user!

    def show
      @user = current_user
    end
    def edit
      @user = current_user
    end
  
    def unsubscribe
    
    end
  
    def withdrawal
      @user = current_user
      @user.update(is_active: false) # 退会フラグを更新
      reset_session # セッション情報を削除
      redirect_to root_path, notice: '退会処理が完了しました。'
    end
  
    def update
      Rails.logger.debug("PARAMS: #{params.inspect}")
      @user = current_user
      if @user.update(user_params)
        redirect_to users_my_page_path(@user), notice: '顧客情報が更新されました。'
      else
        flash.now[:alert] = '更新に失敗しました。入力内容を確認してください。'
        render :edit
      end
    end
  
    private
    def user_params
      params.require(:user).permit(:last_name, :first_name, :email, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number)
    end
  
  end
end