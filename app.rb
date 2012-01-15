require 'rubygems'
require 'sinatra'
require 'haml'
require './models/message.rb'

get '/' do
  @messages = Message.order_by(:posted_date.desc)
  haml :index
end

post '/add' do
  Message.create({
    :url => request[:url],
    :posted_date => Time.now
  })
  redirect '/'
end
