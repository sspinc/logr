require "json"

module Logr
  class JSONFormatter
    def call(severity, time, logger_name, entry)
      line = {
        timestamp: time.utc,
        level: severity,
        logger: logger_name,
      }.merge(entry.to_hash)

      line.to_json + "\n"
    end
  end
end
