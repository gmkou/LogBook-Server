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

end
