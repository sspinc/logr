class StructuredLogger
  Metric = Struct.new(:name, :value, :type) do
    def to_hash; to_h end
  end
end
