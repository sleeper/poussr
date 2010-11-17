require 'sinatra'
require 'json'

require 'poussr/channel'

module Poussr
  class RESTApi < Sinatra::Base

    post '/v1/channels/:channel/events' do
      active = request.body.read
      c = Channel.find_or_create( params[:channel] )
      c.dispatch( params[:name], active )
      status(201)
    end
    
  end
end
