class InputDeserializer
  private

  attr_reader :data

  def initialize(data)
    @data = data
  end

  public

  def stale
    data.fetch('stale')
  end

  def operations
    data.fetch('operations')
  end
end
