require 'eventmachine'
require 'poussr/channel'

module Poussr
  class WSHandler

    def self.subscribe(ws, channel_name)
      puts "FRED: subscription to channel: #{channel_name} received"
      channel = Channel.find_or_create( channel_name)
      sock_id = channel.em_channel.subscribe {|msg| ws.send msg }
    end

    def self.unsubscribe(ws, channel_name)
      channel = Channel.find_or_create( channel_name)
      sock_id = channel.em_channel.unsubscribe {|msg| ws.send msg }
    end

    def self.start(host, port)
      # FIXME: hardcoded host and port
      EventMachine::WebSocket.start(:host => host, :port => port, :debug => true) do |ws|
        
        ws.onopen {
          ws.send "connected!!!!"
        }

        ws.onmessage { |msg|
          # Let's check the message
          begin
            msg_event = JSON.parse(msg)
          rescue JSON::ParserError => e
            STDERR.puts "Error: message is probably not JSON #{e}"
            msg_event = {'event' => ''} 
          end
          
          case msg_event['event']
          when 'poussr:subscribe'
            # Let's create the channel if it's not existing
            # and associate this ws to the right EM::Channel
            WSHandler.subscribe(ws,msg_event['channel'])
          when 'poussr::unsusbscribe'
            # Let's unbind from the channel and associated EM::Channel
            #            WSHandler.unsubscribe(ws,msg_event['channel'])
          else
            puts "got message #{msg}"
          end
        }

        ws.onclose   {
          ws.send "WebSocket closed"
        }
        
      end
    end
  end
end
