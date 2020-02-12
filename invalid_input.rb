class InvalidInput < StandardError
  attr_accessor :msg
  def initialize(msg = "Invalid input")
    @msg = msg
  end
end