require "structured_logger/version"
require "logger"

class StructuredLogger

  def initialize(name, log_device=STDOUT)
    @name = name
    @logger = ::Logger.new(STDOUT).tap do |logger|
      logger.formatter = JSONFormatter.new
    end
  end

  def event(name, options={})
    Entry.new(@name, @logger).event(name, options)
  end

  def metric(name, value, type: "counter")
    Entry.new(@name, @logger).metric(name, value, type)
  end

  def debug(message)
    Entry.new(@name, @logger).debug(message)
  end

  def info(message)
    Entry.new(@name, @logger).info(message)
  end

  def warn(message)
    Entry.new(@name, @logger).warn(message)
  end

  def error(message)
    Entry.new(@name, @logger).error(message)
  end

  def fatal(message)
    Entry.new(@name, @logger).fatal(message)
  end

end
