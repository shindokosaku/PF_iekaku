module Admin
  class RoomsController < ApplicationController
    before_action :set_room, only: [:show, :update, :enter_room]

    def index
      @rooms = Room.all.includes(:user)
      @rooms = Room.order(created_at: :desc).page(params[:page]).per(5)
    end

    def show
      @messages = @room.messages.order(created_at: :asc)
      @message = Message.new 
    end

    # 管理者がルームに入る
    def update
      if @room.corporate_user.nil? 
        if @room.update(corporate_user: current_corporate_user)
          flash[:notice] = "チャットに参加しました"
          redirect_to admin_room_path(@room)
        else
          flash[:alert] = "ルームに入ることができません"
          render :show
        end
      else
        flash[:alert] = "すでに他のユーザーまたは社員が参加しています"
        redirect_to admin_room_path(@room)
      end
    end


    def enter_room
      if @room.update(response_status: '対応済み', corporate_user_id:current_corporate_user.id)
        flash[:notice] = "対応済みにしました"
        redirect_to admin_room_path(@room)
      else
        flash[:alert] = "対応済みにできませんでした"
        render :show
      end
    end

    private

    def set_room
      @room = Room.find_by(id: params[:id])
      unless @room
        flash[:alert] = "指定されたルームは存在しません"
        redirect_to admin_rooms_path
      end
    end
  end
end
