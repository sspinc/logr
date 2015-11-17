require "logger"

require "logr/version"
require "logr/entry"
require "logr/json_formatter"

module Logr
  class Logger
    def initialize(name, level: ::Logger::INFO, log_device: STDOUT)
      @logger = ::Logger.new(log_device).tap do |logger|
        logger.formatter = JSONFormatter.new
        logger.progname = name
        logger.level = level
      end
    end

    def event(name, options={})
      Entry.new(@logger).event(name, options)
    end

    def metric(name, value, type: "counter")
      Entry.new(@logger).metric(name, value, type: type)
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
end
