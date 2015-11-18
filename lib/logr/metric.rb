module Logr
  class Metric
    attr_reader :name, :value, :type

    def initialize(name, value, type)
      raise TypeError, "Metric must be a numeric value" unless value.is_a?(Numeric)
      @name = name
      @value = value
      @type = type
    end

    def to_hash
      {
        name: name,
        value: value,
        type: type
      }
    end
  end
end
