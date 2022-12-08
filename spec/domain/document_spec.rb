require_relative '../../lib/domain/document'

describe Document do
  let(:document) {Document.new("Repl.it uses operational transformations.")}
  describe 'method_missing' do
    it 'should execute update method and do the insert operations' do
      document.method_missing(:update, "insert", "The ")
      expect(document.stale).to eql("The Repl.it uses operational transformations.")
    end

    it 'should execute update method and do the delete operations' do
      document.method_missing(:update, "delete", 8)
      expect(document.stale).to eql("uses operational transformations.")
    end

    it 'should raise InvalidOperaion exception if the operation does not exist' do
      expect{document.method_missing(:update, "inserting", "Test ")}.to raise_error{InvalidOperation}
    end
  end
end
