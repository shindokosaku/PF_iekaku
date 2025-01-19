class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
    @users = User.page(params[:page])
  end

  def show
    
  end

  def edit
   
end
private

  def set_admin
    @admin = Admin.find(params[:id])
  end