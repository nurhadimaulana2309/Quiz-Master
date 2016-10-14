class QuizController < ApplicationController
  before_action :check_score, only: :question
  before_action :set_question
  before_action :increase_question_number, only: :check_answer

  def question
  end

  def check_answer
    answer_score = ScoringAction.get_answer_score(@question.answer, question_params[:answer])
    answer_status = ScoringAction.get_answer_status(answer_score)
    session[:score] += 1 if answer_status.eql? true

    if @question.next
      if answer_status.eql? true
        redirect_to quiz_question_path(@question.next), notice: "Correct Answer!"
      else
        redirect_to quiz_question_path(@question.next), alert: "Wrong Answer!"
      end
    else
      redirect_to results_path, notice: "Finished!"
    end
  end

  private
    def check_score
      redirect_to root_path if session[:score].nil?
    end

    def set_question
      @question = Question.where(id: params[:id]).first
    end

    def question_params
      params.require(:question).permit(:answer)
    end

    def increase_question_number
      session[:question_number] += 1
    end
end