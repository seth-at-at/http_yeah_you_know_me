
class Game
  attr_reader :answer, 
							:guess_counter,
              :num

  def initialize(num = rand(0..99))
    @answer = num
    @guess_counter   = 0
  end

  def game(param_value, verb)
    if verb == "GET"
      play_game
    elsif verb == "POST"
      @redirect = true
      @param_value = param_value[0].to_i
    end
  end

  def play_game
    @redirect = false
    if @param_value
      make_a_guess(@param_value)
    else
      "Please make a guess."
    end
  end

  def make_a_guess(guess)
    guess = guess.to_i
    @guess_counter += 1

    if guess > answer
      response = "too high."
    elsif guess < answer
      response = "too low."
    elsif guess == answer
      response = "correct!"
    end
		
    "You have made #{guess_counter} guess(es)\nYour guess was #{guess}, which is #{response}"
  end

	def redirect?
    @redirect
	end
end