require 'json'
require 'rspec'
require 'rack/test'
require_relative '../../lib/controllers/operational_transformation_controller.rb'


describe OperationalTransformationController do
 include Rack::Test::Methods

 let(:app) { described_class.new }
  describe '/v1/operations/transform' do
    it 'should return latest stale if the operations are valid' do
      request = { "stale": "Repl.it uses operational transformations to keep everyone in a multiplayer repl in sync.",
                  "operations": [ { "op": "delete", "count": 7 },
                                  { "op": "insert", "chars": "We" },
                                  { "op": "skip", "count": 4 },
                                  { "op": "delete", "count": 1 }
                                ]
                }
      post '/v1/operations/transform', request.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response).to be_ok
    end

    it 'should return the same stale if the operations are empty' do
      request = { "stale": "Repl.it uses operational transformations to keep everyone in a multiplayer repl in sync.",
                  "operations": []
                }
      post '/v1/operations/transform', request.to_json, 'CONTENT_TYPE' => 'application/json'
      latest_stale = JSON.parse last_response.body
      expect(last_response).to be_ok
      expect(latest_stale['latest']).to eql(request[:stale])
    end

    it 'should return error message if the operations are not valid' do
      request = { "stale": "Repl.it uses operational transformations to keep everyone in a multiplayer repl in sync.",
                  "operations": [ { "op": "skip", "count": 45 },
                                  { "op": "delete", "count": 47 }
                                ]
                }
      post '/v1/operations/transform', request.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq 400
    end

    it 'should return error if one of the operations is invalid' do
      request = { "stale": "Repl.it uses operational transformations to keep everyone in a multiplayer repl in sync.",
                  "operations": [{ "op": "inserting", "chars": "We " }]
                }
      post '/v1/operations/transform', request.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq 400
    end

    it 'should return error if one of the keys in input is invalid' do
      request = { "stale": "Repl.it uses operational transformations to keep everyone in a multiplayer repl in sync.",
                  "operations": [{ "operation": "insert", "chars": "We " }]
                }
      post '/v1/operations/transform', request.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq 400
    end

    it 'should return error if one of the values type is different' do
      request = { "stale": "Repl.it uses operational transformations to keep everyone in a multiplayer repl in sync.",
                  "operations": [{ "operation": "insert", "chars": 100 }]
                }
      post '/v1/operations/transform', request.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq 400
    end
  end
end
