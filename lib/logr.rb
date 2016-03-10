require "logr/version"
require "logr/logger"

module Logr
  # Parse log level from an environment variable
  #
  # @param default [Symbol] the default log level
  # @param var [String] the environment variable to use
  # @return the parsed logger level as a number
  def self.parse_level(default: :info, var: "LOG_LEVEL")
    valid_levels = %w[DEBUG INFO WARN ERROR FATAL UNKNOWN]

    default = default.upcase
    level = ENV.fetch(var, default).upcase.to_s
    level = valid_levels.find(-> { default }) { |lvl| lvl == level }

    ::Logger.const_get(level)
  end
end
