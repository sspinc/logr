require "spec_helper"

describe Logr do
  describe "parse_level" do
    it "parses the LOG_LEVEL environment variable" do
      with_env("LOG_LEVEL", "error") do
        expect(Logr.parse_level).to eq(Logger::ERROR)
      end
    end

    it "allows to specify the name of the environment variable" do
      with_env("CUSTOM_LOG_LEVEL", "warn") do
        expect(Logr.parse_level(var: "CUSTOM_LOG_LEVEL")).to eq(Logger::WARN)
      end
    end

    it "allows the default level to be set" do
      expect(Logr.parse_level(default: :warn)).to eq(Logger::WARN)
    end

    it "defaults to info without any configuration" do
      expect(Logr.parse_level).to eq(Logger::INFO)
    end

    it "is case insensitive" do
      with_env("LOG_LEVEL", "warn") do
        expect(Logr.parse_level).to eq(Logger::WARN)
      end

      with_env("LOG_LEVEL", "WARN") do
        expect(Logr.parse_level).to eq(Logger::WARN)
      end
    end

    it "rejects not allowed level strings and returns default" do
      with_env("LOG_LEVEL", "not-a-level") do
        expect(Logr.parse_level(default: :error)).to eq(Logger::ERROR)
      end
    end
  end

  def with_env(key, value)
    key, value = key.to_s, value.to_s
    past = ENV[key]
    ENV[key] = value
    yield
    ENV[key] = past
  end
end

