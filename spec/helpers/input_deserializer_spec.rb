require_relative '../../lib/helpers/input_deserializer'

describe InputDeserializer do
  input = { "stale" => "Repl.it uses operational transformations.",
            "operations" => [ { "op" => "delete", "count" => 7 } ]
          }
  let(:deserializer) { InputDeserializer.new(input) }

  describe 'stale' do
    it 'should fetch the stale from the given input' do
      expect(deserializer.stale).to eql("Repl.it uses operational transformations.")
    end
  end

  describe 'operations' do
    it 'should fetch array of operations from the given input' do
      expect(deserializer.operations).to eql([ { "op" => "delete", "count" => 7 } ])
    end
  end
end
