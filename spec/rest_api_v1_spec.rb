require File.dirname(__FILE__) + '/spec_helper'
require File.join(File.dirname(__FILE__), '../lib/poussr', 'rest_api')

require "poussr/channel"

describe "Poussr REST API v1" do
  include Rack::Test::Methods

  def app
    @app ||= Poussr::RESTApi
  end

  describe "Channel resource" do
    # describe "GET index" do
    #   it "should respond to GET /channels" do
    #     get '/channels'
    #     last_response.should be_ok
    #   end

    #   it "should send back JSON" do
    #     get '/channels'
    #     last_response.headers["Content-Type"].should match "application/json"
    #   end

    #   it "should send back the list of available channels" do
        
    #     get '/channels'
    #     channels = JSON.parse(last_response.body)
    #     channels.should be_a Array
    #   end
      
    # end

    # describe "POST create" do
    #   it "should respond to POST /channels"
    # end

    describe "POST events" do

      it "should create a channel (if not yet existing)" do
        event_name = "new_active"
        body = "This is my body"
        post_rest "/v1/channels/mychannel/events", {:name => event_name},body
        last_response.status.should == 201
        Poussr::Channel.find('mychannel').should_not be_nil
      end

      it "should retrieve the correct event name" do
        c = Poussr::Channel.new('mychannel')
        event_name = "new_active"
        body = "This is my body"
        c.should_receive(:dispatch).with(event_name,body)
        post_rest "/v1/channels/mychannel/events", {:name => "new_active"}, body
      end
      
    end
    
  end
end
