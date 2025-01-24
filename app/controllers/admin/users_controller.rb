module Admin
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
      @users = User.order(created_at: :desc).page(params[:page]).per(10)
    end

    def show
    end

    def edit
    end

    def update
      if @user.update(user_params)
        redirect_to admin_user_path(@user), notice: 'ユーザー情報を更新しました。'
      else
        flash.now[:alert] = '更新に失敗しました。'
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: 'ユーザーを削除しました。'
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:nickname, :email, :memo)
    end
  end
end
