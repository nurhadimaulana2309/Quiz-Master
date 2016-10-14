require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do
  describe 'GET #index' do
    it 'assigns @questions' do
      question = create(:question)
      get :index
      expect(assigns(:questions)).to eq([question])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe 'GET #show' do
    it 'assigns @question based on params id' do
      question = create(:question)
      get :show, id: question.id
      expect(assigns(:question)).to eq(question)
    end
  end

  describe 'GET #new' do
    it 'assigns @question as a new question' do
      get :new
      expect(assigns(:question)).to be_a_new(Question)
    end
  end

  describe 'GET #edit' do
    it "assigns @question based on params id" do
      question = create(:question)
      get :edit, id: question.id
      expect(assigns(:question)).to eq(question)
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      before(:each) do
        @question = create(:question)
        put :update, id: @question.id, question: attributes_for(:question)
      end

      it 'update the question' do
        @question.reload
      end

      it 'assigns @question based on updated question' do
        expect(assigns(:question)).to eq(@question)
      end

      it 'redirects to the question page' do
        expect(response).to redirect_to(@question)
      end
    end

    context 'with invalid params' do
      before(:each) do
        @question = create(:question)
        put :update, id: @question.id, question: attributes_for(:question, content: nil)
      end

      it 'assigns @question based on question to be updated' do
        expect(assigns(:question)).to eq(@question)
      end

      it 're-renders the "edit" template' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      question = create(:question)
      delete :destroy, id: question.id
    end

    it 'destroy selected question' do
      expect(Question.count).to eq(0)
    end

    it 'redirects to list questions page' do
      expect(response).to redirect_to(questions_url)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before(:each) do
        post :create, question: attributes_for(:question)
      end

      it 'create a question' do
        expect(Question.count).to eq(1)
      end

      it 'redirects to the "show" action for the new question' do
        expect(response).to redirect_to Question.first
      end
    end

    context 'with invalid attributes' do
      before(:each) do
        post :create, question: attributes_for(:question, content: nil)
      end

      it 'does not create the question' do
        expect(Question.count).to eql(0)
      end

      it 're-render the "new" view' do
        expect(response).to render_template :new
      end
    end
  end
end