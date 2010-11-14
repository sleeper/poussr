require 'sinatra'
require 'json'

module Poussr
  class RESTApi < Sinatra::Base
    get '/channels' do
      content_type :json
      [].to_json
    end 
  end
end
