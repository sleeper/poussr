module Poussr
  class Config
    def initialize
      @ws_host = "0.0.0.0"
      @ws_port = 8080
      @ws_debug = false
      @port = 3000
    end

    def ws_host(h=nil)
      return @ws_host if h.nil?
      @ws_host = h
    end

    def ws_port( p=nil )
      return @ws_port if p.nil?
      @ws_port = p
    end

    def ws_debug( dbg=nil )
      return @ws_dbg if dbg.nil?
      @ws_debug = dbg
    end

    def port ( p=nil )
      return @port if p.nil?
      @port = p
    end
    
  end

  
  class Environment
    def self.configure(&block)
      @config = Config.new
      block.call( @config )
    end

    def self.get_config
      @config
    end
  end
end
