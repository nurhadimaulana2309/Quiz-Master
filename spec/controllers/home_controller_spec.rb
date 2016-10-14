require 'rails_helper'

RSpec.describe HomeController, :type => :controller do
  describe 'GET #index' do
    it 'renders the index template and set sessions' do
      get :index
      session[:score] = 0
      session[:question_number] = 1
      expect(response) == 200
    end
  end
end