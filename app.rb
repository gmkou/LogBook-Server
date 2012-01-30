require 'rubygems'
require 'sinatra'
require 'haml'
require './models/message.rb'

def valid_http_uri?(str)
  URI.split(str).first == 'http' rescue false
end

get '/' do
  @messages = Message.order_by(:posted_date.desc)
  haml :index
end

get '/list' do
  @messages = Message.order_by(:posted_date.desc)
  haml :list
end

post '/add' do
  uri = URI.decode(request[:uri])
  if valid_http_uri?(uri) then
    Message.create({
                     :uri => uri,
                     :posted_date => Time.now
                   })
  end
  redirect '/'
end 

get '/count' do
  p request[:uri]
  if (request[:uri] != nil) then
    uri = URI.decode(request[:uri])
    length = Message.filter(:uri=>uri).count
  else
    length = 0
  end
  "#{length}"
end 
