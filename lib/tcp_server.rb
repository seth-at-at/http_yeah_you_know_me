require'socket'

class TCPServer
	attr_reader :serv_num, :counter

	def initialize(serv_num)
		@serv_num = serv_num
		@counter = 0
	end


  def self.start_server
    counter = 1

    Socket.tcp_server_loop(9292) do |server, address|
      server.gets
      response = "<html><head></head><body><h1>Hello World!(#{counter})</></body></html>"
      server.print "\r\n"
      server.print response
      server.close
      counter += 1
    end

  end
end