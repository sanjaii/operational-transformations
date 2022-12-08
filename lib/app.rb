require 'sinatra/base'
require 'json'

require_relative 'controllers/operational_transformation_controller'

class App < Sinatra::Base
  configure do
      enable :logging
  end

  use OperationalTransformationController
  run!
end
