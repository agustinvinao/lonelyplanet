class Generator
  attr_reader :destination, :overview, :destinations

  def initialize(attrs)
    @destination  = attrs[:destination]
    @overview     = attrs[:overview]
    @destinations = attrs[:destinations]
  end

  def perform
    # override in implementation
  end
end