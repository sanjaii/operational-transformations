class InputDeserializer
  private

  attr_reader :data

  def initialize(request)
    @data = JSON.parse request.body.read
  end

  public

  def stale
    data.fetch('stale')
  end

  def operations
    data.fetch('operations')
  end
end
