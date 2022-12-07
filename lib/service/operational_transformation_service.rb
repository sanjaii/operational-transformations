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

  def actions
    deserializer.actions
  end

  public

  def output
    operation.stale
  end

  def perform_actions
    actions.each do |action|
      document.update(*action.values)
    end
  end
end
