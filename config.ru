require 'rubygems'      # <-- Added this require
require 'em-websocket'
#require 'sinatra/base'
require 'poussr/rest_api'
require 'thin'

EventMachine.run do     # <-- Changed EM to EventMachine
  # class App < Sinatra::Base
  #     get '/' do
  #         return "foo"
  #     end
  # end

  EventMachine::WebSocket.start(:host => '0.0.0.0', :port => 8080) do |ws| # <-- Added |ws|
      # Websocket code here
      ws.onopen {
          ws.send "connected!!!!"
      }

      ws.onmessage { |msg|
          puts "got message #{msg}"
      }

      ws.onclose   {
          ws.send "WebSocket closed"
      }

  end

  # You could also use Rainbows! instead of Thin.
  # Any EM based Rack handler should do.
  Poussr::RESTApi.run!({:port => 3000})    # <-- Changed this line from Thin.start to App.run!
end
