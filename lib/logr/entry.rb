require "logr/event"
require "logr/metric"

module Logr
  class Entry

    attr_reader :metrics, :message

    def initialize(logger, event=nil, metrics=[], message=nil)
      @logger = logger
      @event = event
      @metrics = metrics
      @message = message
    end

    def event(name=nil, tags={})
      if name.nil?
        @event
      else
        Entry.new(@logger, Event.new(name, tags), @metrics)
      end
    end

    def with(tags={})
      if @event.nil?
        raise 'No event to append to. Please call #event first.'
      end
      Entry.new(@logger, @event.with(tags), @metrics)
    end

    def metric(name, value, type: "counter")
      metric = Metric.new(name, value, type)
      Entry.new(@logger, @event, @metrics + [metric])
    end

    def monitored(title, text)
      if @event.nil?
        raise 'No event to monitor. Please call #event first.'
      end
      event = @event.with(monitored: true, title: title, text: text)
      Entry.new(@logger, event, @metrics)
    end

    def debug(message=nil)
      add(:debug, message)
    end

    def info(message=nil)
      add(:info, message)
    end

    def warn(message=nil)
      add(:warn, message)
    end

    def error(message=nil)
      add(:error, message)
    end

    def fatal(message=nil)
      add(:fatal, message)
    end

    def to_hash
      result = {}
      result[:event] = @event.to_hash if @event
      result[:metrics] = @metrics.map(&:to_hash) if @metrics.any?
      result[:message] = @message if @message

      result
    end

    private
    def add(severity, message)
      entry = Entry.new(@logger, @event, @metrics, message)
      @logger.send(severity, entry)
    end
  end
end
