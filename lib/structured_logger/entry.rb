class StrucuredLogger
  class Entry

    def initalize(logger_name, logger, event: nil, metrics: [], message: nil)
      @logger_name = logger_name
      @logger = logger
      @event = event
      @metrics = metrics
    end

    def event(name, options={})
      Entry.new(@logger_name, @logger, Event.new(name, options), @metrics)
    end

    def with(options={})
      Entry.new(@logger_name, @logger, @event.with(options), @metrics)
    end

    def metric(name, value, type: "counter")

    end

    def monitored(subject, body)

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

    private
    def add(severity, message)
      entry = Entry.new(@logger_name, @logger, @event, @metrics, message: message)
      logger.send(severity, entry)
    end
  end
end
