require File.dirname(__FILE__) + '/spec_helper'
require 'poussr/environment'
require 'eventmachine'


describe "Environment" do

  describe "#configure" do
    it "should allow for configuration of websocket server" do
      Poussr::Environment.configure do |c|
        c.ws_host( "foo")
      end
      Poussr::Environment.config.ws_host.should == "foo"
    end
    
    it "should allow for configuration of websocket port"  do
      Poussr::Environment.configure do |c|
        c.ws_port( 1234 )
      end
      Poussr::Environment.config.ws_port.should == 1234
    end
    
    it "should allow for configuration of websocket debugging" do
      Poussr::Environment.configure do |c|
        c.ws_debug( true )
      end
      Poussr::Environment.config.ws_debug.should == true
    end
    
    it "should allow for configuration of REST port" do
      Poussr::Environment.configure do |c|
        c.port( 1234 )
      end
      Poussr::Environment.config.port.should == 1234
    end
    
    it "should allow for configuration of logger" do
      Poussr::Environment.configure do |c|
        c.logger( "foo")
      end
      Poussr::Environment.config.logger.should == "foo"
    end
    
    it "should allow for configuration of log level" do
      Poussr::Environment.configure do |c|
        c.log_level( "foo")
      end
      Poussr::Environment.config.log_level.should == "foo"
    end
    
  end

  describe "defaults" do
    it "should have a default logger" do 
      Poussr::Environment.configure do |c|
        c.ws_port (1234)
      end
      Poussr::Environment.config.logger.should_not be_nil
    end

    
    it "should have a default log_level" do 
      Poussr::Environment.configure do |c|
        c.ws_port (1234)
      end
      Poussr::Environment.config.log_level.should_not be_nil
    end
    
  end

  
end

