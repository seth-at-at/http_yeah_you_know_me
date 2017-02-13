require_relative'test_helper'
require'./lib/tcp_server'
require'faraday'

class TCPServerTest < Minitest::Test
	attr_reader :tcp_server

	def setup
		@tcp_server = TCPServer.new(9292)
	end

	def test_instance_of
		assert_instance_of TCPServer, tcp_server
	end

	def test_can_take_in_server_number
		assert_equal 9292, tcp_server.serv_num
	end

	def test_it_says_hello_world
    # response = Faraday.get 'http://127.0.0.1:9292'

    assert_equal "<html><head></head><body><h1>Hello World!(1)</></body></html>", TCPServer.start_server
	end

	def test_it_increments_the_counter
		# binding.pry
		skip
		response = Faraday.get 'http://127.0.0.1:9292'
		assert_equal "<html><head></head><body><h1>Hello World!(1)</></body></html>", response.body
		
		response = Faraday.get 'http://127.0.0.1:9292'
		assert_equal "<html><head></head><body><h1>Hello World!(2)</></body></html>", response.body
	end

end
