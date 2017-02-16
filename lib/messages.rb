class Messages
	def got_request
    puts "Got this request:"
	end

	def sending_response
  	puts "sending response."
	end

	def good_luck
		"Good luck!"
	end

	def wrote_this(h, o)
		puts ["Wrote this response:", h, o].join("\n")
	end

	def response_complete
	  puts "\nResponse complete, will now exit."
	end
end