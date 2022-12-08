class Document
  private

  attr_reader :cursor

  def initialize(stale)
    @stale = stale
    @cursor = 0
  end

  def valid_operation?(count)
    raise InvalidType unless count.instance_of?(Integer)

    (@cursor + count) < @stale.length
  end

  def delete(count)
    raise InvalidTransformation unless valid_operation?(count)

    @stale = stale[0...cursor] + stale[(cursor + count)..]
  end

  def skip(count)
    raise InvalidTransformation unless valid_operation?(count)

    @cursor += count
  end

  def insert(str)
    raise InvalidType unless str.instance_of?(String)

    @stale.insert(@cursor, str)
    @cursor += str.length
  end

  public

  attr_reader :stale

  def update(type, chars_or_count)
    send(type.to_sym, chars_or_count)
  end
end
