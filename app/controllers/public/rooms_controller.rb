class Public::RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    existing_room = Room.find_by(user_id: current_user.id)
    
    if existing_room
      redirect_to room_path(existing_room), notice: '既にルームが存在します。'
    else
      @room = Room.create(user_id: current_user.id)
      if @room.persisted?
        redirect_to room_path(@room), notice: 'ルームを作成しました。'
      else
        redirect_to some_error_path, alert: 'ルームの作成に失敗しました。'
      end
    end
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.order(created_at: :asc)
    @message = Message.new
  end
end
