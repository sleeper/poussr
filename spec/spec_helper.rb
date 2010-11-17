require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'rspec'
require 'uri'

# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

def post_rest(uri,query={},body={})
  nu = uri + '?' + build_query_string(query)
  post nu, body
end


#
# value must be a hash
#
def build_query_string(value={})
  value.map do |k,v|
    "#{URI.escape(k.to_s)}=#{URI.escape(v)}"
  end.join("&")
end
