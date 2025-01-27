module Admin
  class MessagesController < ApplicationController
    before_action :set_room, only: [:create]
    before_action :ensure_corporate_user_in_room, only: [:create]
  
    def create
      message = @room.messages.build(message_params.merge(corporate_user: current_corporate_user))
      
      if message.body.blank?
        flash[:alert] = "メッセージを入力してください"
        redirect_to admin_room_path(@room) and return
      end
      
      if message.save
        flash[:notice] = "メッセージを送信しました"
        redirect_to admin_room_path(@room)
      else
        flash[:alert] = "メッセージを送信できませんでした"
        messages = @room.messages.order(created_at: :asc)
        render 'admin/rooms/show'
      end
    end
  
    def destroy
      message = @room.messages.find(params[:id])
      if message.destroy
        flash[:notice] = "メッセージを削除しました"
      else
        flash[:alert] = "メッセージの削除に失敗しました"
      end
      redirect_to admin_room_path(@room)
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
