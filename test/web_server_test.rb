require_relative'test_helper'
require'./lib/web_server'

class WebServerTest < Minitest::Test
	attr_reader :server

	def setup
	end

	def test_it_exists
		server = WebServer.new(9292)
		assert_instance_of WebServer, server
	end

	def test_soemthing
		server = WebServer.new(9293)
		assert_equal 7, server.server
	end
end