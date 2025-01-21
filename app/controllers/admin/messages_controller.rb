module Admin
  class MessagesController < ApplicationController
    before_action :set_room
  
    def create
      message = @room.messages.build(message_params.merge(admin: current_admin))
      if message.save
        redirect_to admin_room_path(@room), notice: 'メッセージが送信されました。'
      else
        redirect_to admin_room_path(@room), alert: 'メッセージの送信に失敗しました。'
      end
    end
  
    def destroy
      message = @room.messages.find(params[:id])
      message.destroy
      redirect_to admin_room_path(@room), notice: 'メッセージが削除されました。'
    end
  
    private
  
    def set_room
      @room = Room.find(params[:room_id])
    end
  
    def message_params
      params.require(:message).permit(:body)
    end
  end
end
