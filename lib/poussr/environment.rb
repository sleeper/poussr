require 'logger'

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
      return @ws_debug if dbg.nil?
      @ws_debug = dbg
    end

    def port ( p=nil )
      return @port if p.nil?
      @port = p
    end

    def logger (l=nil)
      @logger ||= Logger.new(STDOUT)
      return @logger if l.nil?
      @logger = l
    end    

    def log_level (l=nil)
      @log_level ||= Logger::INFO
      return @log_level if l.nil?
      @log_level = l
    end    

  end

  class Environment
    def self.configure(&block)
      @config = Config.new
      block.call( @config )
    end

    def self.config
      @config
    end
  end
end
