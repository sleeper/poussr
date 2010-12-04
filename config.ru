require 'rubygems'      # <-- Added this require
require 'em-websocket'
require 'poussr/rest_api'
require 'poussr/ws_handler'
require 'thin'

require ::File.expand_path('../config/environment',  __FILE__)

EventMachine.run do

  cfg = Poussr::Environment.get_config
  
  Poussr::WSHandler.start cfg

  Poussr::RESTApi.run!({:port => cfg.port })

end
