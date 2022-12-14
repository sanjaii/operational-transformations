require_relative '../helpers/error'

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

  def update(type, char_or_count)
    send(type.to_sym, char_or_count)
  end

  def respond_to_missing?(method_name, include_private = false)
    super
  end

  public

  attr_reader :stale

  def method_missing(method_name, *args, &block)
    send(method_name, *args) || super if method_name.to_s == 'update'
  rescue NoMethodError
    raise InvalidOperation
  end
end
