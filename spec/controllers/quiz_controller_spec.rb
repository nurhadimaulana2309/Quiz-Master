require 'rails_helper'

RSpec.describe QuizController, :type => :controller do
  describe 'GET #question' do
    it 'assigns @question' do
      question = create(:question)
      get :question, id: question.id
      expect(assigns(:question)) == (question)
    end

    it 'renders the question template' do
      session[:score] = 0
      question = create(:question)
      get :question, id: question.id
      expect(response).to render_template("question")
    end
  end

  describe 'POST #check_answer' do
    let(:question_with_number_answer) {
        {content: 'What is 5 x 5 = ?', answer: '25'}
      }
    let(:question_with_words_answer){
      {content: 'Where is eiffel tower?', answer: 'France'}
    }

    before(:each) do
      session[:question_number] = 1
      session[:score] = 0
    end

    context 'with correct answer' do
      it "check the correct number with word" do
        session[:question_number] += 1
        question_number_answer = Question.create! question_with_number_answer
        question_words_answer = Question.create! question_with_words_answer
        post :check_answer, id: question_number_answer.id, question: {answer: "twenty five"}
        session[:score] += 1

        expect(response).to redirect_to(quiz_question_path(question_words_answer))
      end

      it "check the correct number with number" do
        session[:question_number] += 1
        question_number_answer = Question.create! question_with_number_answer
        question_words_answer = Question.create! question_with_words_answer
        post :check_answer, id: question_number_answer.id, question: {answer: "25"}
        session[:score] += 1

        expect(response).to redirect_to(quiz_question_path(question_words_answer))
      end

      it "check the correct word" do
        session[:question_number] += 1
        question_words_answer = Question.create! question_with_words_answer
        question_number_answer = Question.create! question_with_number_answer
        post :check_answer, id: question_words_answer.id, question: {answer: "France"}
        session[:score] += 1

        expect(response).to redirect_to(quiz_question_path(question_number_answer))
      end

      it "check the correct word which is not 100% correctly typed" do
        session[:question_number] += 1
        question_words_answer = Question.create! question_with_words_answer
        question_number_answer = Question.create! question_with_number_answer
        post :check_answer, id: question_words_answer.id, question: {answer: "Frnce"}
        session[:score] += 1

        expect(response).to redirect_to(quiz_question_path(question_number_answer))
      end
    end

    context 'with wrong answer' do
      it "check the wrong number with word" do
        session[:question_number] += 1
        question_number_answer = Question.create! question_with_number_answer
        question_words_answer = Question.create! question_with_words_answer
        post :check_answer, id: question_number_answer.id, question: {answer: "twenty four"}

        expect(response).to redirect_to(quiz_question_path(question_words_answer))
      end

      it "check the wrong number with number" do
        session[:question_number] += 1
        question_number_answer = Question.create! question_with_number_answer
        question_words_answer = Question.create! question_with_words_answer
        post :check_answer, id: question_number_answer.id, question: {answer: "24"}

        expect(response).to redirect_to(quiz_question_path(question_words_answer))
      end

      it "check the wrong word" do
        session[:question_number] += 1
        question_words_answer = Question.create! question_with_words_answer
        question_number_answer = Question.create! question_with_number_answer
        post :check_answer, id: question_words_answer.id, question: {answer: "England"}

        expect(response).to redirect_to(quiz_question_path(question_number_answer))
      end
    end

    context 'finish the quiz' do
      it "redirect to result page with correct answer" do
        session[:question_number] += 1
        question_number_answer = Question.create! question_with_number_answer
        post :check_answer, id: question_number_answer.id, question: {answer: "twenty five"}
        session[:score] += 1

        expect(response).to redirect_to(results_path)
      end
    end
  end
end