require 'em/channel'

module Poussr

  class Channel
    @instances = {}
    class << self; attr_accessor :instances; end

    attr_reader :name, :em_channel
    
    def initialize( name )
      @name = name
      @em_channel = EM::Channel.new
      store
    end

    #
    # Dispatch as JSON
    #  { 'channel': 'foo',
    #    'event': 'bar',
    #    'data': { 'my': 'very',
    #              'own': 'struct' }
    #  }
    #
    def dispatch(event_name,body)
      evt = {
        'channel' => self.name,
        'event' => event_name,
        'data' => body
      }
      em_channel.push(evt.to_json)
    end
    
    def store
      self.class.instances[self.name] = self
    end
    
    def self.find( name )
      instances[name]
    end
    
    def self.find_or_create( name )
      find( name ) || Channel.new(name)
    end

    def self.clear
      instances = {}
    end
    
  end
end
