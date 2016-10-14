class ResultsController < ApplicationController
  before_action :check_score
  after_action :clear_session

  def index
    @result_score = session[:score]
  end

  private
    def check_score
      redirect_to root_url if session[:score].nil?
    end

    def clear_session
      session[:score] = nil if session[:score].present?
    end
end