class OperationalTransformationService
  private

  attr_reader :deserializer, :document

  def initialize(deserializer, document)
    @deserializer = deserializer
    @document = document
  end

  def stale
    deserializer.stale
  end

  def operations
    deserializer.operations
  end

  public

  def update_document
    operations.each do |operation|
      document.update(operation.values)
    end
    document.stale
  end
end
