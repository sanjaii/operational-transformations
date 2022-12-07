class InvalidOperation < StandardError
  def initialize(message = 'Transformations failed on the input')
    super
  end
end

class Document
  private

  attr_reader :cursor

  def initialize(stale)
    @stale = stale
    @cursor = 0
  end

  def valid_operation?(count)
    (@cursor + count) < @stale.length
  end

  public

  attr_reader :stale

  def delete(count)
    raise InvalidOperation unless valid_operation?(count)

    @stale = stale[0...cursor] + stale[(cursor + count)..]
  end

  def skip(count)
    raise InvalidOperation unless valid_operation?(count)

    @cursor += count
  end

  def insert(str)
    @stale.insert(@cursor, str)
    @cursor += str.length
  end
end
