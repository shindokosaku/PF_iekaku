class Admin::AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :withdrawal]

  def show
  end

  def edit
  end

  def update
    Rails.logger.debug("PARAMS: #{params.inspect}")
    if @admin.update(admin_params)
      flash[:notice] = "社員情報が更新されました。"
      redirect_to admin_admin_path(@user)
    else
      flash[:alert] = "社員情報の更新に失敗しました。"
      render :edit
    end
  end

  def withdrawal
    @admin.update(is_active: false) # 退会フラグを更新
    reset_session # セッション情報を削除
    redirect_to root_path, notice: '退会処理が完了しました。'
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :affiliated_store, :address, :telephone_number, :status)
  end
end

