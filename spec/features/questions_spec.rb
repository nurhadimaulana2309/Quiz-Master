require 'rails_helper'

feature 'Create a new question' do
  scenario 'with valid input' do
    visit new_question_path
    fill_in 'question[content]', with: 'Where is Eiffel tower?'
    fill_in 'question[answer]', with: 'France'
    click_on 'Create Question'

    expect(page).to have_content('Question was successfully created.')
  end
end