require 'spec_helper'
require 'logger'
require 'json'

describe Logr do
  context 'DEBUG log level' do
    let(:test_output) { StringIO.new }
    let(:logger) { Logr::Logger.new('test_logger', level: Logger::DEBUG, log_device: test_output) }

    %w[debug info warn error fatal].each do |level|
      describe "##{level}" do
        before do
          logger.send(level, 'Test message')
        end

        it 'should print a timestamp' do
          logline = JSON.parse(test_output.string)
          expect(logline.has_key?('timestamp')).to eq(true)
        end

        it 'should print everything else in the correct structure' do
          logline = JSON.parse(test_output.string)
          logline.delete('timestamp')
          expected_logline = {
            'logger'  => 'test_logger',
            'level'   => level.upcase,
            'message' => 'Test message'
          }
          expect(logline).to eq(expected_logline)
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
        logger.warn('Test message')
      end

      it 'should print a timestamp' do
        logline = JSON.parse(test_output.string)
        expect(logline.has_key?('timestamp')).to eq(true)
      end

      it 'should print everything else in the correct structure' do
        logline = JSON.parse(test_output.string)
        logline.delete('timestamp')
        expected_logline = {
          'logger'  => 'test_logger',
          'level'   => 'WARN',
          'message' => 'Test message'
        }
        expect(logline).to eq(expected_logline)
      end
    end

    describe '#error' do
      before do
        logger.error('Test message')
      end

      it 'should print a timestamp' do
        logline = JSON.parse(test_output.string)
        expect(logline.has_key?('timestamp')).to eq(true)
      end

      it 'should print everything else in the correct structure' do
        logline = JSON.parse(test_output.string)
        logline.delete('timestamp')
        expected_logline = {
          'logger'  => 'test_logger',
          'level'   => 'ERROR',
          'message' => 'Test message'
        }
        expect(logline).to eq(expected_logline)
      end
    end
  end
end
