class Admin::RoomsController < ApplicationController
  before_action :set_room, only: [:show, :update]
  def index
    @rooms = Room.where(admin: nil)
  end

  def show
    @messages = @room.messages
  end

  def update
    if @room.update(admin: current_admin)
      flash[:notice] = "チャットに参加しました"
      redirect_to admin_room_path(@room)
    end
  end
private

  def set_room
    @room = Room.find(params[:id])
  end
end
