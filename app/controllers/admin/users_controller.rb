class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.order(created_at: :desc).page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: '顧客情報が更新されました。'
    else
      flash.now[:alert] = '更新に失敗しました。入力内容を確認してください。'
      render :edit
    end
  end

private

  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:nickname, :email, :memo)
  end
end