require 'rubygems'      # <-- Added this require
require 'em-websocket'
require 'poussr/rest_api'
require 'poussr/ws_handler'
require 'thin'

EventMachine.run do
  Poussr::WSHandler.start('0.0.0.0', 8080)

  Poussr::RESTApi.run!({:port => 3000})
end
