class InvalidTransformation < StandardError
  def initialize(message = 'Transformation failed on the input')
    super
  end
end

class InvalidType < TypeError
  def initialize(message = 'Invalid input')
    super
  end
end
