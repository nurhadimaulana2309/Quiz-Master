class ScoringAction
  class << self
    #
    # get answer score based on comparing correct answer and user answer
    #
    def get_answer_score(correct_answer, user_answer)
      jarow = FuzzyStringMatch::JaroWinkler.create( :native )
      jarow.getDistance(convert_to_simple_word(correct_answer), convert_to_simple_word(user_answer))
    end

    #
    # get answer status based on answer score
    #
    def get_answer_status(answer_score)
      status = false
      if answer_score >= 0.9 and answer_score <= 1.0
        status = true
      end
    end

    #
    # make it downcase and convert it to word if it is a number
    #
    def convert_to_simple_word(answer)
      array_answer = answer.downcase.split(" ")
      array_answer.map! do |answer|
        is_numeric?(answer) == true ? answer.to_f.to_words(remove_hyphen: true) : answer
      end
      answer = array_answer.join(" ")
    end

    #
    # check whether word is numeric or not
    #
    def is_numeric?(word)
      true if Float(word) rescue false
    end
  end
end