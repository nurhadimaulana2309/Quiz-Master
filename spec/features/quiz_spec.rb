require 'rails_helper'

feature 'Take a quiz' do
  before(:each) do
    # set session
    page.set_rack_session(score: 0)
    page.set_rack_session(question_number: 1)

    # create questions
    @question1 = Question.create!({content: "Where is Eiffel tower?", answer: "France"})
    @question2 = Question.create!({content: "What is 5 x 5 ?", answer: "25"})
  end

  scenario 'Answer with correct answer and go to the next question' do
    visit quiz_question_path(@question1)
    fill_in "question[answer]", with: "France"
    click_on 'Submit'

    expect(page).to have_content('Correct Answer!')
  end

  scenario 'Answer with wrong answer and go to the next question' do
    visit quiz_question_path(@question1)
    fill_in "question[answer]", with: "England"
    click_on 'Submit'

    expect(page).to have_content('Wrong Answer!')
  end

  scenario 'Answer with correct answer and go to result page' do
    visit quiz_question_path(@question2)
    fill_in "question[answer]", with: "25"
    click_on 'Submit'

    expect(page).to have_content('Finished!')
  end
end