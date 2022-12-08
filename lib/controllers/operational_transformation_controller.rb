require 'sinatra/base'
require_relative '../domain/document'
require_relative '../service/operational_transformation_service'
require_relative '../helpers/input_deserializer'
require_relative '../helpers/error'

class OperationalTransformationController < Sinatra::Base
  def initialize(app = nil)
    super(app)
  end

  post '/v1/operations/transform' do
    request.body.rewind
    body = JSON.parse request.body.read
    deserializer = InputDeserializer.new(body)
    document = Document.new(deserializer.stale)
    operational_transformation_service = OperationalTransformationService.new(deserializer, document)

    { "latest": operational_transformation_service.update_document }.to_json
  rescue InvalidTransformation, InvalidOperation, KeyError, InvalidType => e
    status 400
    { "message": e.message }.to_json
  end
end
