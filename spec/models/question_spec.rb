require 'rails_helper'

RSpec.describe Question, :type => :model do
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:answer) }

  it 'has a valid question' do
    expect(build(:question)).to be_valid
  end

  it 'get the next question' do
    first_question = create(:question)
    second_question = create(:question)
    expect(first_question.next).to eq(second_question)
  end

  it 'return nil if there is only one question' do
    first_question = create(:question)
    expect(first_question.next).to be_nil
  end
end
