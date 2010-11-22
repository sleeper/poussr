require 'eventmachine'
require 'em-http-request'
require 'json'

EventMachine.run {
  http = EventMachine::HttpRequest.new("ws://127.0.0.1:8080/").get :timeout => 0
 
  http.errback { puts "oops" }
  
  http.callback {
    puts "WebSocket connected. Subscribing to channel 'mychannel'"
    subscribe_evt = {'event' => 'poussr:subscribe', 'channel' => 'mychannel'}.to_json
    http.send subscribe_evt
  }
 
  http.stream { |msg|
    puts "Received: #{msg}"
#    http.send "Pong: #{msg}"
  }
}
