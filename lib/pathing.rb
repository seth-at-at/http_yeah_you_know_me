require_relative'word_search'
require_relative'messages'
require_relative'game'

class Pathing
  attr_reader :counter, 
							:hello_counter,
							:message

  def initialize
    @redirect = false
    @hello_counter = 0
    @counter = 0
		@message = Messages.new
  end

  def main_greeting
    "Hello, World! (#{@counter})"
  end

  def hello_greeting
    "Hello, World! (#{@hello_counter += 1})"
  end

  def iterm_paths(path_road, p_value, format_response, verb)
    counting_path(path_road)

    case path_road
			when "/hello"
				path_output = hello_greeting
			when "/datetime"
				path_output = datetime
			when "/total_requests"
				path_output = total_requests
			when "/word_search"
				path_output = WordSearch.new.word_search(p_value)
			when "/start_game"
				path_output = start_game
			when "/game"
				path_output = @game_instance.game(p_value, verb)
			else
				path_output = ""
    end
		
  end

  def counting_path(path_road)
    if path_road != "/favicon.ico"
      @counter += 1
    end
  end

  def datetime
    Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')
  end

  def total_requests
    "Total requests: #{counter}"
  end

  def start_game
    @game_instance = Game.new(rand(0..100))
		message.good_luck
  end

  def redirect?
    @game_instance ? @game_instance.redirect? : false
  end

end