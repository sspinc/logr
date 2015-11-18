module Logr
  class Event
    attr_reader :name, :tags

    def initialize(name, tags)
      @name, @tags = name, tags
    end

    def to_hash
      { name: @name }.merge(@tags)
    end

    def with(tags)
      Event.new(@name, @tags.merge(tags))
    end
  end
end
