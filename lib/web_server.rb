require_relative'tcp_server'
require_relative'pathing'
require'socket'

class WebServer
	attr_reader :server_num, :counter, :server

  def initialize(serv_num)
    @server        = TCPServer.new(serv_num)
    @path_options  = Pathing.new
  end

  def start_server
    @client = server.accept
    @request_lines = []

    while line = client.gets && !line.chomp.empty?
      request_lines << line.chomp
    end

    request_lines
  end

  def server_response
    @output  = "<html><head></head><body>#{@response}</body></html>"
  end

end