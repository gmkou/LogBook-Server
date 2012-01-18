require 'rubygems'
require 'sinatra'
require 'haml'
require './models/message.rb'

get '/' do
  @messages = Message.order_by(:posted_date.desc)
  haml :index
end

get '/list' do
  @messages = Message.order_by(:posted_date.desc)
  haml :list
end

post '/add' do

  def valid_http_uri?(str)
    URI.split(str).first == 'http' rescue false
  end

  if valid_http_uri?(request[:uri]) then
    Message.create({
                     :uri => request[:uri],
                     :posted_date => Time.now
                   })
  end
  redirect '/'
end 
