class HelpfulMarksController < ApplicationController
  before_action :set_question

  def toggle
    if current_user
      helpful_mark = @question.helpful_marks.find_by(user_id: curret_user.id)
    elsif current_corrent_corporate_user
      helpful_mark = @question.helpful_marks.find_by(corporate_user_id: current_corporate_user.id)
    else
      helpful_mark = @question.helpful_marks.find_by(ip_address: request.remote_ip)
    end

    if helpful_mark
      helpful_mark.destroy
      @status = "removed"
    else
      @question.helpful_marks.create(
        user: current_user,
        corporate_user: current_corporate_user,
        ip_address: current_user || current_corporate_user ? nil : request.remote_ip
      )
      @status = "added"
    end

    respond_to do |format|
      format.html { redirect_to questions_path }
      format.json { render json: { status: @status, count: @question.helpful_marks.count } }
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end
end