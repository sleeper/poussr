require 'sinatra'
require 'json'

require 'poussr/channel'

module Poussr
  class RESTApi < Sinatra::Base
    
    get '/channels' do
      content_type :json
      Channel.all.to_json
    end 
  end
end
