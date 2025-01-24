class MessagesController < ApplicationController
  before_action :set_room

  def create
    @message = @room.messages.build(message_params)

    # 現在の送信者を設定
    if current_user
      @message.user_id = current_user.id
    elsif current_corporate_user
      @message.corporate_user_id = current_corporate_user.id
    else
      flash[:alert] = "送信者が特定できません"
      redirect_to root_path and return
    end

    if @message.save
      flash[:notice] = "メッセージが送信されました"
      redirect_to room_path(@room)
    else
      flash[:alert] = "メッセージの送信に失敗しました"
      render "rooms/show"
    end
  end

  def destroy
    @message = @room.messages.find(params[:id])
    @message.destroy
    flash[:notice] = "メッセージを削除しました"
    redirect_to room_path(@room)
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end

  def room_view_path(room)
    if current_corporate_user
      "admin/rooms"
    else
      "public/rooms"
    end
  end
end
