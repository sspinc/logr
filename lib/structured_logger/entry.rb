require "structured_logger/event"
require "structured_logger/metric"

class StructuredLogger
  class Entry

    def initialize(logger, event=nil, metrics=[], message=nil)
      @logger = logger
      @event = event
      @metrics = metrics
      @message = message
    end

    def event(name, options={})
      Entry.new(@logger, Event.new(name, options), @metrics)
    end

    def with(options={})
      Entry.new(@logger, @event.with(options), @metrics)
    end

    def metric(name, value, type: "counter")
      metric = Metric.new(name, value, type)
      Entry.new(@logger, @event, @metrics + [metric])
    end

    def monitored(subject, body)
      event = @event.with(monitored: true, subject: subject, body: body)
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
