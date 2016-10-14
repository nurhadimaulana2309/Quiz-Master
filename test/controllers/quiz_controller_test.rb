require 'test_helper'

class QuizControllerTest < ActionController::TestCase
  test "should get question" do
    get :question
    assert_response :success
  end

end
