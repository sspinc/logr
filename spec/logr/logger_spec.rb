require 'spec_helper'
require 'logger'
require 'json'
require 'timecop'

describe Logr::Logger do
  context 'DEBUG log level' do
    let(:test_output) { StringIO.new }
    let(:logger) { Logr::Logger.new('test_logger', level: Logger::DEBUG, log_device: test_output) }

    %w[debug info warn error fatal].each do |level|
      describe "##{level}" do
        before do
          Timecop.freeze(Time.local(1990))
          logger.send(level, 'Test message')
        end

        after do
          Timecop.return
        end

        it 'should print a logline containing the logger name' do
          logline = JSON.parse(test_output.string)
          expect(logline).to include('logger' => 'test_logger')
        end

        it 'should print a logline containing the level' do
          logline = JSON.parse(test_output.string)
          expect(logline).to include('level' => level.upcase)
        end

        it 'should print a logline containing the timestamp' do
          logline = JSON.parse(test_output.string)
          expect(logline).to include('timestamp' => Time.now.utc.to_s)
        end

        it 'should print a logline containing the message' do
          logline = JSON.parse(test_output.string)
          expect(logline).to include('message' => 'Test message')
        end
      end
    end
  end

  context 'WARN log level' do
    let(:test_output) { StringIO.new }
    let(:logger) { Logr::Logger.new('test_logger', level: Logger::WARN, log_device: test_output) }

    describe '#info' do
      before do
        logger.info('Test message')
      end

      it 'should not print anything' do
        expect(test_output.string).to be_empty
      end
    end

    describe '#warn' do
      before do
        Timecop.freeze(Time.local(1990))
        logger.warn('Test message')
      end

      after do
        Timecop.return
      end

      it 'should print a logline containing the logger name' do
        logline = JSON.parse(test_output.string)
        expect(logline).to include('logger' => 'test_logger')
      end

      it 'should print a logline containing the level' do
        logline = JSON.parse(test_output.string)
        expect(logline).to include('level' => 'WARN')
      end

      it 'should print a logline containing the timestamp' do
        logline = JSON.parse(test_output.string)
        expect(logline).to include('timestamp' => Time.now.utc.to_s)
      end

      it 'should print a logline containing the message' do
        logline = JSON.parse(test_output.string)
        expect(logline).to include('message' => 'Test message')
      end
    end

    describe '#error' do
      before do
        Timecop.freeze(Time.local(1990))
        logger.error('Test message')
      end

      after do
        Timecop.return
      end

      it 'should print a logline containing the logger name' do
        logline = JSON.parse(test_output.string)
        expect(logline).to include('logger' => 'test_logger')
      end

      it 'should print a logline containing the level' do
        logline = JSON.parse(test_output.string)
        expect(logline).to include('level' => 'ERROR')
      end

      it 'should print a logline containing the timestamp' do
        logline = JSON.parse(test_output.string)
        expect(logline).to include('timestamp' => Time.now.utc.to_s)
      end

      it 'should print a logline containing the message' do
        logline = JSON.parse(test_output.string)
        expect(logline).to include('message' => 'Test message')
      end
    end
  end
end
