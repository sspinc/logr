require "logger"

require "structured_logger/version"
require "structured_logger/entry"
require "structured_logger/json_formatter"

class StructuredLogger

  def initialize(name, log_device=STDOUT)
    @logger = ::Logger.new(STDOUT).tap do |logger|
      logger.formatter = JSONFormatter.new
      logger.progname = name
    end
  end

  def event(name, options={})
    Entry.new(@logger).event(name, options)
  end

  def metric(name, value, type: "counter")
    Entry.new(@logger).metric(name, value, type)
  end

  def debug(message)
    Entry.new(@logger).debug(message)
  end

  def info(message)
    Entry.new(@logger).info(message)
  end

  def warn(message)
    Entry.new(@logger).warn(message)
  end

  def error(message)
    Entry.new(@logger).error(message)
  end

  def fatal(message)
    Entry.new(@logger).fatal(message)
  end

end
