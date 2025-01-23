class Corporate_user::RoomsController < ApplicationController
  before_action :set_room, only: [:show, :update]
  def index
    @rooms = Room.all.includes(:user)
    @rooms = Room.order(created_at: :desc).page(params[:page])
    @rooms = Room.where(corporate_user: nil)
  end

  def show
    @room = Room.find(params[:id])
    # 管理者がルームに入った際に「対応済み」に変更
    @room.update(response_status: '対応済')
    @messages = @room.messages.order(created_at: :asc)
    @message = Message.new 
  end

  # 管理者がルームに入る
  def update
    if @room.update(corporate_user: current_corporate_user)
      flash[:notice] = "チャットに参加しました"
      redirect_to corporate_user_room_path(@room)
    else
      flash[:alert] = "ルームに入ることができません"
      render :show
    end
  end
private

  def set_room
    @room = Room.find(params[:id])
  end
end
