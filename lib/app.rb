require 'sinatra/base'
require 'json'

class App < Sinatra::Base
  configure do
      enable :logging
  end
  run!
end
