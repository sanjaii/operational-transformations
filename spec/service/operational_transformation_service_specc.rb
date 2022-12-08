require_relative '../../lib/service/operational_transformation_service'
require_relative '../../lib/helpers/input_deserializer'
require_relative '../../lib/domain/document'

describe OperationalTransformationService do
  input = { "stale" => "Repl.it uses operational transformations.",
            "operations" => [ { "op" => "delete", "count" => 7 } ]
          }
  let(:deserializer) { InputDeserializer.new(input) }
  let(:document) {Document.new(deserializer.stale)}
  let(:operational_transformation_service) {OperationalTransformationService.new(deserializer, document)}

  describe 'update_document' do
    it 'should return the updated stale' do
      stale = operational_transformation_service.update_document
      expect(stale).to eql(" uses operational transformations.")
    end
  end
end
