class StructuredLogger
  class Event
    def initialize(name, context)
      @name, @context = name, context
    end

    def to_hash
      { name: @name }.merge(@context)
    end

    def with(context)
      Event.new(@name, @context.merge(context))
    end
  end
end
