require './app'
require 'test/unit'
require 'rack/test'

set :environment, :test

class AddTest < Test::Unit::TestCase

  def test_it_says_hello_world
    browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
    browser.get '/'
    assert browser.last_response.ok?
    assert browser.last_response.body.include?('Hello, World')
  end

  def test_it_returns_uri
    browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
    browser.post '/add', :uri => 'http://www.yahoo.co.jp'
    browser.get '/list'
    assert browser.last_response.body.include?('http://www.yahoo.co.jp')
  end

  def test_it_returns_uri_count
    browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
    browser.get '/count'
    assert_equal '0', browser.last_response.body
     browser.get '/count', :uri => 'http://www.yahoo.co.jp'
    assert_equal '1', browser.last_response.body
  end

end
