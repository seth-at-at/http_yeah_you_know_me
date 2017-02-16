require_relative'test_helper'
require'faraday'
require'socket'
require'./lib/web_server'

class TCPServerTest < Minitest::Test

  def setup
    @time = Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')
  end
  
  def test_response
    client = Faraday.new("http://127.0.0.1:9292")
    response = client.get("http://127.0.0.1:9292")

    assert response.success?
    assert_equal "127.0.0.1", client.host
    assert_equal 9292, client.port
  end

  def test_client_returns_body
    client = Faraday.new("http://127.0.0.1:9292")
    response = client.get("http://127.0.0.1:9292")
    output = "<html><head></head><body><pre>\n\nVerb: GET\nPath: /\nProtocol: HTTP/1.1\nUser-Agent: Faraday v0.11.0\nPort: \nOrigin:  Faraday v0.11.0\n</pre></body></html>"
    assert_equal output, response.body
  end

  def test_path_output_with_greeting
    client = Faraday.new("http://127.0.0.1:9292")
    response = client.get("http://127.0.0.1:9292/hello")
    output = "<html><head></head><body><pre>Hello, World! (1)\n\nVerb: GET\nPath: /hello\nProtocol: HTTP/1.1\nUser-Agent: Faraday v0.11.0\nPort: \nOrigin:  Faraday v0.11.0\n</pre></body></html>"
    assert_equal output, response.body
  end

  def test_response_with_date_time
    client = Faraday.new("http://127.0.0.1:9292")
    response = client.get("http://127.0.0.1:9292/datetime")
    output = "<html><head></head><body><pre>#{@time}\n\nVerb: GET\nPath: /datetime\nProtocol: HTTP/1.1\nUser-Agent: Faraday v0.11.0\nPort: \nOrigin:  Faraday v0.11.0\n</pre></body></html>"
    assert_equal output, response.body
  end

end