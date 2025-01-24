module Admin
  class MessagesController < ApplicationController
    before_action :set_room, only: [:create]
    before_action :ensure_corporate_user_in_room, only: [:create]
  
    def create
      @message = @room.messages.new(message_params.merge(corporate_user: current_corporate_user))
      if @message.save
        flash[:notice] = "メッセージを送信しました"
        redirect_to admin_room_path(@room)
      else
        flash[:alert] = "メッセージを送信できませんでした"
        @messages = @room.messages.order(created_at: :asc)
        render 'admin/rooms/show'
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

    def ensure_corporate_user_in_room
      unless @room.corporate_user == current_corporate_user
        flash[:alert] = "ルームに入っている社員のみ返信可能です"
        redirect_to admin_room_path(@room)
      end
    end
  
    def message_params
      params.require(:message).permit(:body)
    end
  end
end
