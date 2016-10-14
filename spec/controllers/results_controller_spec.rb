require 'rails_helper'

RSpec.describe ResultsController, :type => :controller do
  describe 'GET #index' do
    it 'assigns @result_score' do
      get :index
      result_score = 1
      expect(assigns(:result_score)) == result_score
    end

    it 'renders the index template and clear score session' do
      session[:score] = 1
      get :index
      session[:score] = nil
      expect(response).to render_template("index")
    end
  end
end