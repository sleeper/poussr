require File.dirname(__FILE__) + '/spec_helper'

describe "Poussr REST API" do
  include Rack::Test::Methods

  def app
    @app ||= Poussr::RESTApi#Sinatra::Application
  end

  describe "Channel resource" do
    describe "GET index" do
      it "should respond to GET /channels" do
        get '/channels'
        last_response.should be_ok
      end

      it "should send back JSON" do
        get '/channels'
        last_response.headers["Content-Type"].should match "application/json"
      end

      it "should send back the list of available channels" do
        
        get '/channels'
        channels = JSON.parse(last_response.body)
        channels.should be_a Array
      end
      
    end

    describe "POST create" do
      it "should respond to POST /channels"
    end    
  end
end
