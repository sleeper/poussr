require File.dirname(__FILE__) + '/spec_helper'
require 'poussr/logging'
require 'eventmachine'
require 'stringio'


describe "Logging" do

  describe "defaults" do
    it "should have a default logger" do
      Poussr.logger.should_not be_nil
      Poussr.logger.should be_a_kind_of Logger
    end
    
    it "should log only 'info' level" do
      Poussr.log_level.should == Logger::INFO
    end
  end

  describe "#logger" do
    it "should be configurable" do
      a =  StringIO.new
      Poussr.logger = a
      Poussr.logger.should == a
    end    
  end
  
  describe "#log_level" do
    it "should be changeable" do
      Poussr.log_level = Logger::DEBUG
      Poussr.log_level.should == Logger::DEBUG
    end
  end  
end
