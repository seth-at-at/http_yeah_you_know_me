require_relative'test_helper'
require'./lib/pathing'
require'./lib/word_search'

class PathingTest < Minitest::Test

	def setup 
		@response = "Hello, World! (1)\n\nVerb: GET\nPath: /\nProtocol: HTTP/1.1\nHost: localhost:9292\nPort: 9292\nOrigin:  localhost:9292\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
    @path = Pathing.new
	end

  def test_hello_greeting_is_hello
    assert_equal "Hello, World! (1)", @path.hello_greeting
  end

	def test_main_greeting_is_hello
		assert_equal "Hello, World! (0)", @path.main_greeting
	end

  def test_request_count_returns_total_requests
    47.times do
      @path.iterm_paths("/hello", [], @response_body, "GET")
    end
		
    assert_equal "Total requests: 48", @path.iterm_paths("/total_requests", [], @response_body, "GET")
  end

	def test_game_path_post_verb_sets_redirect_to_true
    @path.iterm_paths("/start_game", [], @response_body, "POST")
    @path.iterm_paths("/game", [], @response_body, "POST")
    assert @path.redirect?
	end

  def test_different_responses_to_more_than_one_request
    result1 = Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')
    result2 = ""
    result3 = "Hello, World! (1)"

    assert_equal result1, @path.iterm_paths("/datetime", [], @response_body, "GET")
    assert_equal result2, @path.iterm_paths("/", [], @response_body, "GET")
    assert_equal result3, @path.iterm_paths("/hello", [], @response_body, "GET")
  end
end