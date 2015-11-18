require 'spec_helper'
require 'json'

describe Logr::JSONFormatter do
  let(:severity) { 'DEBUG' }
  let(:time) { Time.now }
  let(:logger) { 'logger_name' }
  let(:entry) { {'test' => 'entry'} }

  describe '#call' do
    let(:logline) { JSON.parse(Logr::JSONFormatter.new.call(severity, time, logger, entry)) }

    it 'should include a timestamp' do
      expect(logline).to include('timestamp' => time.utc.to_s)
    end

    it 'should include a severity' do
      expect(logline).to include('level' => severity)
    end

    it 'should include a logger name' do
      expect(logline).to include('logger' => logger)
    end

    it 'should include the entry' do
      expect(logline).to include(entry)
    end
  end
end
