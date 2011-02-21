require 'logger'

module Poussr
  
  def self.logger
    @logger ||= Logger.new(STDOUT)    
  end

  def self.logger=( l )
    @logger = l
  end
  
  def self.log_level
    @log_level ||= Logger::INFO
  end

  def self.log_level=(level)
    @log_level = level
  end
  
end
