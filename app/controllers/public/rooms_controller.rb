class Public::RoomsController < ApplicationController
  before_action :authenticate_user!

  def create 
    @room = Room.find_or_create_by(user_id: current_user.id, admin_id: nil)
    redirect_to room_path(@room)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room. messages
  end
end
