require File.dirname(__FILE__) + '/spec_helper'
require 'poussr/channel'

describe "Channel" do

  before :each do
    Poussr::Channel.clear
  end
  
  describe "new" do

    it "should create and register a new channel" do
      c = Poussr::Channel.new( 'mychannel' )
      c.should_not be_nil
      Poussr::Channel.find( 'mychannel' ).should_not be_nil
    end
    
  end

  describe "find" do
    it "should return previously created channel" do
      c = Poussr::Channel.new( 'mychannel' )
      Poussr::Channel.find( 'mychannel' ).should_not be_nil
    end
    
    it "should return nil if channel is not yet created" do
      Poussr::Channel.find( 'foo').should be_nil
    end
  end

  describe "find_or_create" do
    it "should return a channel if already existing" do
      c = Poussr::Channel.new( 'mychannel' )
      Poussr::Channel.find_or_create( 'mychannel' ).should_not be_nil      
    end

    it "should create a channel if not existing" do
      Poussr::Channel.find_or_create( 'foo' ).should_not be_nil      
    end
  end

  describe "dispatch" do
    it "should receive an event name and a body"
    
  end
end
