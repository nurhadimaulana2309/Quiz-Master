class HomeController < ApplicationController
  def index
    session[:score] = 0
    session[:question_number] = 1
  end
end