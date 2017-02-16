require_relative'test_helper'
require'hurley'
require'socket'
require'./lib/web_server'

class TCPServerTest < Minitest::Test
	attr_reader :server

	def setup
    @request_lines = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Connection: keep-alive", "Cache-Control: no-cache", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36", "Postman-Token: caad7182-899e-751e-acc0-dab87a96eca0", "Accept: */*", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    @time = Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')
	end

	def test_it_exists
		server = TCPServer.new(9292)
		assert_instance_of TCPServer, server
	end

  def test_response
    client = Hurley::Client.new "http://127.0.0.1:9292"
    response = client.get("http://127.0.0.1:9292")

    assert response.success?
    assert_equal "127.0.0.1", client.host
    assert_equal 9292, client.port
  end

  def test_client_returns_body
    client = Hurley::Client.new "http://127.0.0.1:9292"
    response = client.get("http://127.0.0.1:9292")
    output = "<html><head></head><body><pre>\n\nVerb: GET\nPath: /\nProtocol: HTTP/1.1\nUser-Agent: Hurley v0.2\nPort: \nOrigin:  Hurley v0.2\n</pre></body></html>"
    assert_equal output, response.body
  end

  def test_path_output_for_greeting
    client = Hurley::Client.new "http://127.0.0.1:9292"
    response = client.get("http://127.0.0.1:9292/hello")
    output = "<html><head></head><body><pre>Hello, World! (1)\n\nVerb: GET\nPath: /hello\nProtocol: HTTP/1.1\nUser-Agent: Hurley v0.2\nPort: \nOrigin:  Hurley v0.2\n</pre></body></html>"
    assert_equal output, response.body
  end

 def test_response_when_path_is_date_time
    client = Hurley::Client.new "http://127.0.0.1:9292"
    response = client.get("http://127.0.0.1:9292/datetime")
    output = "<html><head></head><body><pre>#{@time}\n\nVerb: GET\nPath: /datetime\nProtocol: HTTP/1.1\nUser-Agent: Hurley v0.2\nPort: \nOrigin:  Hurley v0.2\n</pre></body></html>"
    assert_equal output, response.body
 end

 def test_response_when_path_is_word_search_with_parameter_values
    client = Hurley::Client.new "http://127.0.0.1:9292"
    response = client.get("http://127.0.0.1:9292/word_search?word=snow")
    output = "<html><head></head><body><pre>SNOW is a known word\n\nVerb: GET\nPath: /word_search?word=snow\nProtocol: HTTP/1.1\nUser-Agent: Hurley v0.2\nPort: \nOrigin:  Hurley v0.2\n</pre></body></html>"
    assert_equal output, response.body
 end

 def test_response_when_path_is_game_with_guess
    client = Hurley::Client.new "http://127.0.0.1:9292"
    response = client.get("http://127.0.0.1:9292/word_search?word=snow")
    output = "<html><head></head><body><pre>SNOW is a known word\n\nVerb: GET\nPath: /word_search?word=snow\nProtocol: HTTP/1.1\nUser-Agent: Hurley v0.2\nPort: \nOrigin:  Hurley v0.2\n</pre></body></html>"
    assert_equal output, response.body
 end

 def test_response_when_path_is_start_game
    client = Hurley::Client.new "http://127.0.0.1:9292"
    response = client.post("http://127.0.0.1:9292/start_game")
    output = "<html><head></head><body><pre>Good luck!\n\nVerb: POST\nPath: /start_game\nProtocol: HTTP/1.1\nUser-Agent: Hurley v0.2\nPort: \nOrigin:  Hurley v0.2\nHost: 127.0.0.1:9292</pre></body></html>"
    assert_equal output, response.body
 end

 def test_response_when_path_is_game_and_wrong_guess_is_made
    client = Hurley::Client.new "http://127.0.0.1:9292"
    client.post("http://127.0.0.1:9292/start_game")
    response = client.post("http://127.0.0.1:9292/game?guess=35")
    output = "<html><head></head><body><pre>You have made 1 guess(es)\nYour guess was 35, which is too low.\n\nVerb: GET\nPath: /game?guess=35\nProtocol: HTTP/1.1\nUser-Agent: Hurley v0.2\nPort: \nOrigin:  Hurley v0.2\nHost: 127.0.0.1:9292</pre></body></html>"
    assert_equal output, response.body
 end

 def test_response_when_path_is_game_and_correct_guess_is_made
    client = Hurley::Client.new "http://127.0.0.1:9292"
    client.post("http://127.0.0.1:9292/start_game")
    response = client.post("http://127.0.0.1:9292/game?guess=72")
    output = "<html><head></head><body><pre>You have made 1 guess(es)\nYour guess was 72, which is correct!\n\nVerb: GET\nPath: /game?guess=72\nProtocol: HTTP/1.1\nUser-Agent: Hurley v0.2\nPort: \nOrigin:  Hurley v0.2\nHost: 127.0.0.1:9292</pre></body></html>"
    assert_equal output, response.body
 end
end