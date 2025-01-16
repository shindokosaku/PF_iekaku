module Public
  class UsersController < ApplicationController

    before_action :authenticate_user!
    before_action :set_user, only: [:show, :edit, :withdrawal, :update]

    def show
      @questions = @user.questions
    end

    def edit
    end
  
    def unsubscribe
    
    end
  
    def withdrawal
      @user.update(is_active: false) # 退会フラグを更新
      reset_session # セッション情報を削除
      redirect_to root_path, notice: '退会処理が完了しました。'
    end
  
    def update
      Rails.logger.debug("PARAMS: #{params.inspect}")
      if @user.update(user_params)
        flash[:notice] = "プロフィールが更新されました。"
        redirect_to user_path(@user)
      else
        flash[:alert] = "プロフィールの更新に失敗しました。"
        render :edit
      end
    end
  
    private

    def set_user
      @user= current_user
    end

    def user_params
      params.require(:user).permit(:nickname, :email, )
    end
  end
end