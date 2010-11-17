module Poussr

  class Channel
    @instances = {}
    class << self; attr_accessor :instances; end

    attr_reader :name
    
    def initialize( name )
      @name = name
      store
    end

    def dispatch(event_name,body)
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
