require "logger"

require "logr/entry"
require "logr/json_formatter"

module Logr
  class Logger
    def initialize(name, level: Logr.parse_level, log_device: STDOUT)
      @logger = ::Logger.new(log_device).tap do |logger|
        logger.formatter = JSONFormatter.new
        logger.progname = name
        logger.level = level
      end
    end

    def event(name, tags={})
      Entry.new(@logger).event(name, tags)
    end

    def metric(name, value, type: "counter")
      Entry.new(@logger).metric(name, value, type: type)
    end

    def debug(message=nil, &block)
      Entry.new(@logger).debug(message, &block)
    end

    def info(message=nil, &block)
      Entry.new(@logger).info(message, &block)
    end

    def warn(message=nil, &block)
      Entry.new(@logger).warn(message, &block)
    end

    def error(message=nil, &block)
      Entry.new(@logger).error(message, &block)
    end

    def fatal(message=nil, &block)
      Entry.new(@logger).fatal(message, &block)
    end
  end
end
